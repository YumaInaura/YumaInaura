# Docs

# https://stripe.com/docs/api/subscription_schedules/release
# https://support.stripe.com/questions/create-update-and-schedule-subscriptions
#
# https://stripe.com/docs/billing/subscriptions/subscription-schedules
# https://stripe.com/docs/billing/subscriptions/subscription-schedules/use-cases

# Code

require 'stripe'

Stripe::api_key = ENV['STRIPE_SECRET_KEY']

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
def create_subscription_schedule(idempotency_key:, plan:)
  @tax_rate ||= Stripe::TaxRate.create(display_name: 'Tax Rate', percentage: 10.0, inclusive: false)
  @customer ||= Stripe::Customer.create
  @payment_method ||= Stripe::PaymentMethod.create(type: 'card', card: { number: '4242424242424242', exp_year: 2030, exp_month: 01})
  @customer_payment_method ||= Stripe::PaymentMethod.attach(@payment_method.id, customer: @customer.id)

  subscription_schedule = Stripe::SubscriptionSchedule.create(
    {
      customer: @customer.id,
      start_date: 'now',
      default_settings: {
        default_payment_method: @customer_payment_method.id,
      },
      phases: [
        {
          plans:
            [
              { plan: plan.id, quantity: 1 },
            ],
            default_tax_rates: [@tax_rate],
            iterations: 3,
        },
      ],
    },
    {
      idempotency_key: idempotency_key
    },
  )
end

idempotency_key = SecureRandom.uuid
# 8006eaa9-018d-40a5-8114-c1af41494880

puts "idempotency_key: #{idempotency_key}"

product1 = Stripe::Product.create(name: "Gold plan #{rand(9999999999)}")
plan1 = Stripe::Plan.create(interval: 'day', currency: 'jpy', amount: 5000, product: product1.id, usage_type: 'licensed')

subscription_schedule_once = create_subscription_schedule(idempotency_key: idempotency_key, plan: plan1)
subscription_schedule_twice = create_subscription_schedule(idempotency_key: idempotency_key, plan: plan1)

puts subscription_schedule_once.id
# e.g
# sub_sched_1G6qlUCmti5jpytUyCOARQ2c

puts subscription_schedule_twice.id
# e.g
# sub_sched_1G6qlUCmti5jpytUyCOARQ2c

# put_subscription_schedule(subscription_schedule_once, 'CREATED')
# put_subscription_schedule(subscription_schedule_twice, 'CREATED')

puts (subscription_schedule_once == subscription_schedule_twice)
# true

plan2 = Stripe::Plan.create(interval: 'day', currency: 'jpy', amount: 5000, product: product1.id, usage_type: 'licensed')

# When Onother Plan Specified
# (Status 400) (Request req_VQeV20P7dDODvh) Keys for idempotent requests can only be used with the same parameters they were first used with. Try using a key other than '8006eaa9-018d-40a5-8114-c1af41494880' if you meant to execute a different request.
# Keys for idempotent requests can only be used with the same parameters they were first used with. Try using a key other than '8006eaa9-018d-40a5-8114-c1af41494880' if you meant to execute a different request.
begin
  create_subscription_schedule(idempotency_key: idempotency_key, plan: plan2)
rescue => exception
  puts exception.to_s
  puts exception.message
end
