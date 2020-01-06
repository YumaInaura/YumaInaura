# Docs

# https://stripe.com/docs/api/subscription_schedules/release
# https://support.stripe.com/questions/create-update-and-schedule-subscriptions
#
# https://stripe.com/docs/billing/subscriptions/subscription-schedules
# https://stripe.com/docs/billing/subscriptions/subscription-schedules/use-cases

# Code

require 'stripe'

Stripe::api_key = ENV['STRIPE_SECRET_KEY']

product1 = Stripe::Product.create(name: "Gold plan #{rand(9999999999)}")
plan1 = Stripe::Plan.create(interval: 'day', currency: 'jpy', amount: 5000, product: product1.id, usage_type: 'licensed')

product2 = Stripe::Product.create(name: "Silver plan #{rand(9999999999)}")
plan2 = Stripe::Plan.create(interval: 'day', currency: 'jpy', amount: 3000, product: product2.id, usage_type: 'licensed')

product3 = Stripe::Product.create(name: "Bronse plan #{rand(9999999999)}")
plan3 = Stripe::Plan.create(interval: 'day', currency: 'jpy', amount: 1000, product: product3.id, usage_type: 'licensed')

tax_rate = Stripe::TaxRate.create(display_name: 'Tax Rate', percentage: 10.0, inclusive: false)
customer = Stripe::Customer.create
payment_method = Stripe::PaymentMethod.create(type: 'card', card: { number: '4242424242424242', exp_year: 2030, exp_month: 01})
customer_payment_method = Stripe::PaymentMethod.attach(payment_method.id, customer: customer.id)

def put_subscription_schedule(subscription_schedule, message)
  puts '-' * 100
  puts "Subscription Schedule"
  puts message
  puts '-' * 100
  puts subscription_schedule
  puts '-' * 100
  puts "https://dashboard.stripe.com/test/subscription_schedules/#{subscription_schedule.id}"
end

# https://stripe.com/docs/api/subscription_schedules/create
subscription_schedule = Stripe::SubscriptionSchedule.create(
  {
    customer: customer.id,
    start_date: Time.now.to_i + 5,
    default_settings: {
      default_payment_method: customer_payment_method.id,
    },
    phases: [
      {
        plans:
          [
            { plan: plan1.id, quantity: 1 },
            { plan: plan2.id, quantity: 4 },
          ],
          default_tax_rates: [tax_rate],
          iterations: 3,
      },
      {
        plans:
          [
            { plan: plan2.id, quantity: 1 },
            { plan: plan3.id, quantity: 1 },
          ],
          default_tax_rates: [tax_rate],
          iterations: 5,
      },
      {
        plans:
          [
            { plan: plan3.id, quantity: 3 },
            { plan: plan1.id, quantity: 2 },
          ],
          default_tax_rates: [tax_rate],
          iterations: 7,
      }
    ],
  }
)
put_subscription_schedule(subscription_schedule, 'CREATED')

puts '-' * 100
puts "Wait until subscription schedule starts"
puts '-' * 100
until subscription_schedule.status == 'active' do
  subscription_schedule = Stripe::SubscriptionSchedule.retrieve(subscription_schedule.id)
  puts subscription_schedule.status
  sleep 2
end

started_subscription_schedule = Stripe::SubscriptionSchedule.retrieve(id: subscription_schedule.id, expand: ['subscription'])
put_subscription_schedule(started_subscription_schedule, 'STARTED')

created_subscription = started_subscription_schedule.subscription

canceled_subscription_schedule = Stripe::SubscriptionSchedule.cancel(started_subscription_schedule.id)
canceled_subscription = Stripe::Subscription.retrieve(canceled_subscription_schedule.subscription)

# Time.now
# => 2020-01-01 17:46:53 +0900

# Time.at(canceled_subscription.current_period_start)
# => 2020-01-01 17:39:14 +0900

# Time.at(canceled_subscription.current_period_end)
# => 2020-01-02 17:39:14 +0900

# Time.at(canceled_subscription.cancel_at)
# => 2020-01-04 17:39:14 +0900

# Time.at(canceled_subscription.canceled_at)
# => 2020-01-01 17:39:14 +0900

binding.pry


# require 'hashdiff'
# Hashdiff.diff(created_subscription.to_h, canceled_subscription.to_h)

# Hashdiff.diff(created_subscription.to_h, canceled_subscription.to_h)
# => [["~", "ended_at", nil, 1577868005],
#  ["~", "latest_invoice", "in_1Fw2kICmti5jpytUobVkbVrD", "in_1Fw2kLCmti5jpytUzguDVLbr"],
#  ["~", "status", "active", "canceled"]]

subscription_changes = created_subscription.to_h.to_a - canceled_subscription.to_h.to_a

# If you need release not cancel
# Stripe::SubscriptionSchedule.release(started_subscription_schedule.id)


# e.g
# => [[:ended_at, nil], [:latest_invoice, "in_1Fw2kICmti5jpytUobVkbVrD"], [:status, "active"]]

# released_subscription_schedule = Stripe::SubscriptionSchedule.retrieve(id: subscription_schedule.id, expand: ['subscription'])
# released_subscription = Stripe::Subscription.retrieve(subscription.id)
#removed_from_subscription_by_released_schedule =  subscription.to_a - released_subscription.to_a
# Subscription "cancel_at" removed by Subscription release
# e.g
# => [[:cancel_at, 1585720051], [:canceled_at, 1577857651], [:schedule, "sub_sched_1Fw03HCmti5jpytUpJMypWcA"]]



# Build update phases structure from first created subscription schedule
#
# SubscriptionSchedule has no "iterations" property in it self
# Because it handles iterations by start_date / end_date and cycle of plans
update_subscription_schedule_phases = subscription_schedule.phases.map do |phase|
  plans = phase.plans.map do |plan|
    { plan: plan.plan, quantity: plan.quantity }
  end;

  {
    plans: plans,
    default_payment_method: phase.default_payment_method,
    start_date: phase.start_date,
    end_date: phase.end_date,
  }
end

# Example
# Keep current phase but remove next come phases
updated_subscription_schedule = Stripe::SubscriptionSchedule.update(
  subscription_schedule.id,
  {
    phases: [
      update_subscription_schedule_phases[0]
    ]
  }
)
put_subscription_schedule(updated_subscription_schedule, 'UPDATED')

# Example
# Update and reset to same phases on subscription shcedule created
updated_subscription_schedule = Stripe::SubscriptionSchedule.update(
  subscription_schedule.id,
  {
    phases: update_subscription_schedule_phases
  }
)
put_subscription_schedule(updated_subscription_schedule, 'UPDATED')



# Stripe::InvalidRequestError: You can only adjust the end date to a future date for the current phase.
#
# updated_subscription_schedule = Stripe::SubscriptionSchedule.update(
#   subscription_schedule.id,
#   {
#     phases: [update_subscription_schedule_phases[1]]
#   }
# )

# https://stripe.com/docs/api/subscription_schedules/update
#
# no customer id because already knows customer
# no start_date because already set start_date when created
#
# If
#   no phases has start_date
# Then
#   Stripe::InvalidRequestError: The subscription schedule update is missing at least one phase with a `start_date` to anchor end dates to.
#
# If
#   not equal subscription_schedule.current_phase.start_date
#     e.g
#     update_start_date_set_on_first_phase = subscription_schedule.current_phase.start_date + 1
#     update_start_date_set_on_first_phase = subscription_schedule.current_phase.start_date - 1
# Then
#   Stripe::InvalidRequestError: You can only adjust the end date to a future date for the current phase.
# This message seems strange for me
update_start_date_set_on_first_phase = subscription_schedule.current_phase.start_date

# Example
# Update and shuffle phases and subscriptions
updated_subscription_schedule = Stripe::SubscriptionSchedule.update(
  subscription_schedule.id,
  {
    phases: [
      {
        plans:
          [
            { plan: plan1.id, quantity: [*1..10].sample },
            { plan: plan2.id, quantity: [*1..10].sample },
          ],
          default_payment_method: customer_payment_method.id,
          default_tax_rates: [tax_rate],
          iterations: [*1..10].sample,
          start_date: update_start_date_set_on_first_phase,
      },
      {
        plans:
          [
            { plan: plan2.id, quantity: [*1..10].sample },
            { plan: plan3.id, quantity: [*1..10].sample },
          ],
          default_payment_method: customer_payment_method.id,
          default_tax_rates: [tax_rate],
          iterations: [*1..10].sample,
      }
    ]
  }
)
put_subscription_schedule(updated_subscription_schedule, 'UPDATED')



# subscription = Stripe::Subscription.retrieve(id: subscription_schedule.subscription, expand: ['schedule', 'latest_invoice'])
# puts subscription
# puts '-' * 100
# puts "Subscription created"
# puts "https://dashboard.stripe.com/test/subscriptions/#{subscription.id}"
# puts '-' * 100

# binding.pry

# Stripe::SubscriptionSchedule.release(subscription_schedule.id)
# Stripe::SubscriptionSchedule.retrieve(subscription_schedule.id)

# exit

# latest_invoice = subscription.latest_invoice
# puts latest_invoice
# puts '-' * 100
# puts "Invoice created"
# puts '-' * 100

# paid_invoice = Stripe::Invoice.pay(latest_invoice.id)
# puts paid_invoice
# puts '-' * 100
# puts "Invoice payment probably succeeded"
# puts "https://dashboard.stripe.com/test/invoices/#{latest_invoice.id}"
# puts '-' * 100
# puts 'YAY!'

# retrieve_invoice = Stripe::Invoice.retrieve(id: latest_invoice.id, expand: ['subscription','subscription.schedule'])
# puts '-' * 100
# puts "Retrieve subscription from invoice"
# puts '-' * 100
# puts retrieve_invoice.subscription
# puts '-' * 100
# puts "Retrieve subscription schedule from invoice"
# puts '-' * 100
# puts retrieve_invoice.subscription.schedule

# puts '-' * 100
# puts "You can See in Dash boards"
# puts '-' * 100
# puts "https://dashboard.stripe.com/test/subscription_schedules/#{subscription_schedule.id}"
# puts "https://dashboard.stripe.com/test/subscriptions/#{subscription.id}"
# puts "https://dashboard.stripe.com/test/invoices/#{latest_invoice.id}"

