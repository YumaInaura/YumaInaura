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
plan1 = Stripe::Plan.create(interval: 'month', currency: 'jpy', amount: 5000, product: product1.id, usage_type: 'licensed', metadata: { traffic_gigabytes: 1.5 })

tax_rate = Stripe::TaxRate.create(display_name: 'Tax Rate', percentage: 10.0, inclusive: false)
customer = Stripe::Customer.create
payment_method = Stripe::PaymentMethod.create(type: 'card', card: { number: '4242424242424242', exp_year: 2030, exp_month: 01})
customer_payment_method = Stripe::PaymentMethod.attach(payment_method.id, customer: customer.id)

def put_subscription_schedule_focused(subscription_schedule, message = nil)
  puts '=' * 100
  puts "subscription : #{subscription_schedule.subscription}"
  puts "phase start_date: #{Time.at(subscription_schedule.phases[0].start_date)}"
  puts "phase end_date: #{Time.at(subscription_schedule.phases[0].end_date)}"
end

def put_subscription_schedule_detail(subscription_schedule, message = nil)
  puts '=' * 100
  puts "Subscription Schedule"
  puts '-' * 100
  puts subscription_schedule
  puts '-' * 100
  puts "https://dashboard.stripe.com/test/subscription_schedules/#{subscription_schedule.id}"
end


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
        iterations: 6,
        default_tax_rates: [tax_rate],
      },
      {
        plans:
          [
            { plan: plan1.id, quantity: 1 },
          ],
        iterations: 6,
        default_tax_rates: [tax_rate],
      },
    ],
  }
)


binding.pry

put_subscription_schedule_focused(subscription_schedule)


updated_subscription_schedule = Stripe::SubscriptionSchedule.update(
  subscription_schedule.id,
  {
    phases: [
      {
        plans:
          [
            { plan: plan1.id, quantity: 1 },
          ],
        start_date: subscription_schedule.phases[0].start_date,
        iterations: 12,
        default_tax_rates: [tax_rate],
      },
      {
        plans:
          [
            { plan: plan1.id, quantity: 1 },
          ],
        iterations: 12,
        default_tax_rates: [tax_rate],
      },
    ],
  }
)

put_subscription_schedule_focused(updated_subscription_schedule)


put_subscription_schedule_detail(subscription_schedule)

put_subscription_schedule_detail(updated_subscription_schedule)


# ====================================================================================================
# subscription : sub_GaAIWjNiGaH1vE
# phase start_date: 2020-01-20 22:06:53 +0900
# phase end_date: 2020-07-20 22:06:53 +0900
# ====================================================================================================
# subscription : sub_GaAIWjNiGaH1vE
# phase start_date: 2020-01-20 22:06:53 +0900
# phase end_date: 2021-01-20 22:06:53 +0900
# ====================================================================================================
# Subscription Schedule
# ----------------------------------------------------------------------------------------------------
# {
#   "id": "sub_sched_1G2zxxCmti5jpytUnzyEIdPZ",
#   "object": "subscription_schedule",
#   "canceled_at": null,
#   "completed_at": null,
#   "created": 1579525613,
#   "current_phase": {
#     "end_date": 1595250413,
#     "start_date": 1579525613
#   },
#   "customer": "cus_GaAI7DfrzdsgEM",
#   "default_settings": {
#     "billing_thresholds": null,
#     "collection_method": "charge_automatically",
#     "default_payment_method": "pm_1G2zxvCmti5jpytUFqXBw5Zn",
#     "default_source": null,
#     "invoice_settings": null
#   },
#   "end_behavior": "release",
#   "livemode": false,
#   "metadata": {
#   },
#   "phases": [
#     {
#       "application_fee_percent": null,
#       "billing_thresholds": null,
#       "collection_method": null,
#       "coupon": null,
#       "default_payment_method": null,
#       "default_tax_rates": [
#         {
#           "id": "txr_1G2zxvCmti5jpytUIWjELIRV",
#           "object": "tax_rate",
#           "active": true,
#           "created": 1579525611,
#           "description": null,
#           "display_name": "Tax Rate",
#           "inclusive": false,
#           "jurisdiction": null,
#           "livemode": false,
#           "metadata": {
#           },
#           "percentage": 10.0
#         }
#       ],
#       "end_date": 1595250413,
#       "invoice_settings": null,
#       "plans": [
#         {
#           "billing_thresholds": null,
#           "plan": "plan_GaAIKTmuqnHpHu",
#           "quantity": 1,
#           "tax_rates": [

#           ]
#         }
#       ],
#       "prorate": true,
#       "start_date": 1579525613,
#       "tax_percent": 10.0,
#       "trial_end": null
#     },
#     {
#       "application_fee_percent": null,
#       "billing_thresholds": null,
#       "collection_method": null,
#       "coupon": null,
#       "default_payment_method": null,
#       "default_tax_rates": [
#         {
#           "id": "txr_1G2zxvCmti5jpytUIWjELIRV",
#           "object": "tax_rate",
#           "active": true,
#           "created": 1579525611,
#           "description": null,
#           "display_name": "Tax Rate",
#           "inclusive": false,
#           "jurisdiction": null,
#           "livemode": false,
#           "metadata": {
#           },
#           "percentage": 10.0
#         }
#       ],
#       "end_date": 1611148013,
#       "invoice_settings": null,
#       "plans": [
#         {
#           "billing_thresholds": null,
#           "plan": "plan_GaAIKTmuqnHpHu",
#           "quantity": 1,
#           "tax_rates": [

#           ]
#         }
#       ],
#       "prorate": true,
#       "start_date": 1595250413,
#       "tax_percent": 10.0,
#       "trial_end": null
#     }
#   ],
#   "released_at": null,
#   "released_subscription": null,
#   "renewal_interval": null,
#   "status": "active",
#   "subscription": "sub_GaAIWjNiGaH1vE"
# }
# ----------------------------------------------------------------------------------------------------
# https://dashboard.stripe.com/test/subscription_schedules/sub_sched_1G2zxxCmti5jpytUnzyEIdPZ
# ====================================================================================================
# Subscription Schedule
# ----------------------------------------------------------------------------------------------------
# {
#   "id": "sub_sched_1G2zxxCmti5jpytUnzyEIdPZ",
#   "object": "subscription_schedule",
#   "canceled_at": null,
#   "completed_at": null,
#   "created": 1579525613,
#   "current_phase": {
#     "end_date": 1611148013,
#     "start_date": 1579525613
#   },
#   "customer": "cus_GaAI7DfrzdsgEM",
#   "default_settings": {
#     "billing_thresholds": null,
#     "collection_method": "charge_automatically",
#     "default_payment_method": "pm_1G2zxvCmti5jpytUFqXBw5Zn",
#     "default_source": null,
#     "invoice_settings": {
#       "days_until_due": null
#     }
#   },
#   "end_behavior": "release",
#   "livemode": false,
#   "metadata": {
#   },
#   "phases": [
#     {
#       "application_fee_percent": null,
#       "billing_thresholds": null,
#       "collection_method": null,
#       "coupon": null,
#       "default_payment_method": null,
#       "default_tax_rates": [
#         {
#           "id": "txr_1G2zxvCmti5jpytUIWjELIRV",
#           "object": "tax_rate",
#           "active": true,
#           "created": 1579525611,
#           "description": null,
#           "display_name": "Tax Rate",
#           "inclusive": false,
#           "jurisdiction": null,
#           "livemode": false,
#           "metadata": {
#           },
#           "percentage": 10.0
#         }
#       ],
#       "end_date": 1611148013,
#       "invoice_settings": null,
#       "plans": [
#         {
#           "billing_thresholds": null,
#           "plan": "plan_GaAIKTmuqnHpHu",
#           "quantity": 1,
#           "tax_rates": [

#           ]
#         }
#       ],
#       "prorate": true,
#       "start_date": 1579525613,
#       "tax_percent": 10.0,
#       "trial_end": null
#     },
#     {
#       "application_fee_percent": null,
#       "billing_thresholds": null,
#       "collection_method": null,
#       "coupon": null,
#       "default_payment_method": null,
#       "default_tax_rates": [
#         {
#           "id": "txr_1G2zxvCmti5jpytUIWjELIRV",
#           "object": "tax_rate",
#           "active": true,
#           "created": 1579525611,
#           "description": null,
#           "display_name": "Tax Rate",
#           "inclusive": false,
#           "jurisdiction": null,
#           "livemode": false,
#           "metadata": {
#           },
#           "percentage": 10.0
#         }
#       ],
#       "end_date": 1642684013,
#       "invoice_settings": null,
#       "plans": [
#         {
#           "billing_thresholds": null,
#           "plan": "plan_GaAIKTmuqnHpHu",
#           "quantity": 1,
#           "tax_rates": [

#           ]
#         }
#       ],
#       "prorate": true,
#       "start_date": 1611148013,
#       "tax_percent": 10.0,
#       "trial_end": null
#     }
#   ],
#   "released_at": null,
#   "released_subscription": null,
#   "renewal_interval": null,
#   "status": "active",
#   "subscription": "sub_GaAIWjNiGaH1vE"
# }
# ----------------------------------------------------------------------------------------------------
# https://dashboard.stripe.com/test/subscription_schedules/sub_sched_1G2zxxCmti5jpytUnzyEIdPZ
