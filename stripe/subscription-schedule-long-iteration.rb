# Docs

# https://stripe.com/docs/billing/subscriptions/subscription-schedules
# https://stripe.com/docs/billing/subscriptions/subscription-schedules/use-cases
#
# https://stripe.com/docs/api/subscription_schedules/release
# https://support.stripe.com/questions/create-update-and-schedule-subscriptions

require 'active_support/core_ext'
require 'stripe'

Stripe::api_key = ENV['STRIPE_SECRET_KEY']

  product1 = Stripe::Product.create(name: "Gold plan #{rand(9999999999)}")
  plan1 = Stripe::Plan.create(interval: 'month', currency: 'jpy', amount: 5000, product: product1.id, usage_type: 'licensed')

  tax_rate = Stripe::TaxRate.create(display_name: 'Tax Rate', percentage: 10.0, inclusive: false)
  customer = Stripe::Customer.create
  payment_method = Stripe::PaymentMethod.create(type: 'card', card: { number: '4242424242424242', exp_year: 2030, exp_month: 01})
  customer_payment_method = Stripe::PaymentMethod.attach(payment_method.id, customer: customer.id)

  def put_subscription_schedule(subscription_schedule, message)
    puts '=' * 100
    puts "Subscription Schedule"
    puts message
    puts '-' * 100
    puts subscription_schedule
    puts '-' * 100
    puts "https://dashboard.stripe.com/test/subscription_schedules/#{subscription_schedule.id}"
  end

iterasions_variations = [nil, 1, 12*20]

iterasions_variations.each do |iterasions|
  # https://stripe.com/docs/api/subscription_schedules/create
  subscription_schedule = Stripe::SubscriptionSchedule.create(
    {
      customer: customer.id,
      start_date: 'now',
      default_settings: {
        default_payment_method: customer_payment_method.id,
      },
      phases: [
        {
          plans:
            [
              { plan: plan1.id, quantity: 1 },
            ],
          iterations: iterasions,
          default_tax_rates: [tax_rate],
        },
      ],
    }
  )

  puts "=" * 100
  puts "ITERASIONS #{iterasions}"
  puts "NOW: #{Time.now}"
  puts "start_date: #{Time.at(subscription_schedule.phases[0].start_date)}"
  puts "end_date: #{Time.at(subscription_schedule.phases[0].end_date)}"
  # put_subscription_schedule(subscription_schedule, "CREATED")
end


# when iterasions 12*21 (months)
# Exception: Stripe::InvalidRequestError: You cannot create a subscription schedule that ends more than 20 years in the future.

# ====================================================================================================
# ITERASIONS
# NOW: 2020-01-20 20:49:05 +0900
# start_date: 2020-01-20 20:49:04 +0900
# end_date: 2020-02-20 20:49:04 +0900
# ====================================================================================================
# ITERASIONS 1
# NOW: 2020-01-20 20:49:06 +0900
# start_date: 2020-01-20 20:49:05 +0900
# end_date: 2020-02-20 20:49:05 +0900
# ====================================================================================================
# ITERASIONS 240
# NOW: 2020-01-20 20:49:07 +0900
# start_date: 2020-01-20 20:49:06 +0900
# end_date: 2040-01-20 20:49:06 +0900
