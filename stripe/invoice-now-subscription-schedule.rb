# Docs

# https://stripe.com/docs/api/subscription_schedules/create
#
# Invoicing workflow | Stripe Billing
# https://stripe.com/docs/billing/invoices/workflow
#
# https://stripe.com/docs/api/invoices/

# Code

require 'stripe'

Stripe::api_key = ENV['STRIPE_SECRET_KEY']

product = Stripe::Product.create(name: "Gold plan #{rand(9999999999)}")
plan = Stripe::Plan.create(interval: 'month', currency: 'jpy', amount: 1000, product: product.id)
tax_rate = Stripe::TaxRate.create(display_name: 'Tax Rate', percentage: 10.0, inclusive: false)
customer = Stripe::Customer.create
payment_method = Stripe::PaymentMethod.create(type: 'card', card: { number: '4242424242424242', exp_year: 2030, exp_month: 01})
customer_payment_method = Stripe::PaymentMethod.attach(payment_method.id, customer: customer.id)

# Subscription create case
# subscription = Stripe::Subscription::create( customer: customer.id, default_payment_method: customer_payment_method.id, items: [{ plan: plan.id }], default_tax_rates: [tax_rate] )

# Set start_date to immediately start schedule
subscription_schedule = Stripe::SubscriptionSchedule.create(
  {
    customer: customer.id,
    # start_date: Time.now.to_i + (24 * 60 * 60 * 100), # e.g specifffy 100 days after
    start_date: Time.now.to_i +  5,
    end_behavior: 'cancel',
    phases: [
      {
        plans:
          [
            {plan: plan.id, quantity: 1},
          ],
          iterations: 1,
          default_payment_method: customer_payment_method.id,
          default_tax_rates: [tax_rate],
      },
    ],
  }
)

puts '-' * 100
puts "Subscription Schedule created"
puts '-' * 100
puts subscription_schedule

puts '-' * 100
puts "Wait until subscription schedule starts"
puts '-' * 100
until subscription_schedule.status == 'active' do
  subscription_schedule = Stripe::SubscriptionSchedule.retrieve(subscription_schedule.id)
  puts subscription_schedule.status
  sleep 2
end

subscription = Stripe::Subscription.retrieve(id: subscription_schedule.subscription, expand: ['schedule', 'latest_invoice'])
puts subscription
puts '-' * 100
puts "Subscription created"
puts '-' * 100

latest_invoice = subscription.latest_invoice
puts latest_invoice
puts '-' * 100
puts "Invoice created"
puts '-' * 100

paid_invoice = Stripe::Invoice.pay(latest_invoice.id)
puts paid_invoice
puts '-' * 100
puts "Invoice payment probably succeeded"
puts '-' * 100
puts 'YAY!'

retrieve_invoice = Stripe::Invoice.retrieve(id: latest_invoice.id, expand: ['subscription','subscription.schedule'])
puts '-' * 100
puts "Retrieve subscription from invoice"
puts '-' * 100
puts retrieve_invoice.subscription
puts '-' * 100
puts "Retrieve subscription schedule from invoice"
puts '-' * 100
puts retrieve_invoice.subscription.schedule

puts '-' * 100
puts "You can See in Dash boards"
puts '-' * 100
puts "https://dashboard.stripe.com/test/subscription_schedules/#{subscription_schedule.id}"
puts "https://dashboard.stripe.com/test/subscriptions/#{subscription.id}"
puts "https://dashboard.stripe.com/test/invoices/#{latest_invoice.id}"
