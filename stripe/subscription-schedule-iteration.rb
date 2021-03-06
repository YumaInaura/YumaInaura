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

# https://stripe.com/docs/api/subscription_schedules/create
one_iteration_phase_subscription_schedule = Stripe::SubscriptionSchedule.create(
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
        iterations: 1,
        default_tax_rates: [tax_rate],
      },
    ],
  }
)

subscription = Stripe::SubscriptionSchedule.retrieve(id: one_iteration_phase_subscription_schedule.id, expand: ['subscription']).subscription

put_subscription_schedule(one_iteration_phase_subscription_schedule, 'CREATED')

puts '=' * 100
puts "Subscription"
puts '-' * 100
puts subscription

puts '=' * 100

puts "subscription.start_date"
puts subscription.start_date
# 1578971185
puts Time.at(subscription.start_date)
# 2020-01-14 12:06:25 +0900

puts "subscription.cancel_at"
puts subscription.cancel_at
# 1581649585
puts Time.at(subscription.cancel_at)
# 2020-02-14 12:06:25 +0900

puts "subscription.cancel_at - subscription.start_date"
puts subscription.cancel_at - subscription.start_date
# 2678400

# ====================================================================================================
# Subscription Schedule
# CREATED
# ----------------------------------------------------------------------------------------------------
# {
#   "id": "sub_sched_1G0fqfCmti5jpytUPM2cabvW",
#   "object": "subscription_schedule",
#   "canceled_at": null,
#   "completed_at": null,
#   "created": 1578971625,
#   "current_phase": {
#     "end_date": 1581650025,
#     "start_date": 1578971625
#   },
#   "customer": "cus_GXlNPhRzhFurG0",
#   "default_settings": {
#     "billing_thresholds": null,
#     "collection_method": "charge_automatically",
#     "default_payment_method": "pm_1G0fqcCmti5jpytUZqUVXDB9",
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
#           "id": "txr_1G0fqbCmti5jpytU8GzFSIGc",
#           "object": "tax_rate",
#           "active": true,
#           "created": 1578971621,
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
#       "end_date": 1581650025,
#       "invoice_settings": null,
#       "plans": [
#         {
#           "billing_thresholds": null,
#           "plan": "plan_GXlNWMKQvQVlHP",
#           "quantity": 1,
#           "tax_rates": [

#           ]
#         }
#       ],
#       "prorate": true,
#       "start_date": 1578971625,
#       "tax_percent": 10.0,
#       "trial_end": null
#     }
#   ],
#   "released_at": null,
#   "released_subscription": null,
#   "renewal_interval": null,
#   "status": "active",
#   "subscription": "sub_GXlNu35gDwcliZ"
# }
# ----------------------------------------------------------------------------------------------------
# https://dashboard.stripe.com/test/subscription_schedules/sub_sched_1G0fqfCmti5jpytUPM2cabvW
# ====================================================================================================
# Subscription
# ----------------------------------------------------------------------------------------------------
# {
#   "id": "sub_GXlNu35gDwcliZ",
#   "object": "subscription",
#   "application_fee_percent": null,
#   "billing_cycle_anchor": 1581650025,
#   "billing_thresholds": null,
#   "cancel_at": 1581650025,
#   "cancel_at_period_end": false,
#   "canceled_at": 1578971625,
#   "collection_method": "charge_automatically",
#   "created": 1578971625,
#   "current_period_end": 1581650025,
#   "current_period_start": 1578971625,
#   "customer": "cus_GXlNPhRzhFurG0",
#   "days_until_due": null,
#   "default_payment_method": "pm_1G0fqcCmti5jpytUZqUVXDB9",
#   "default_source": null,
#   "default_tax_rates": [
#     {
#       "id": "txr_1G0fqbCmti5jpytU8GzFSIGc",
#       "object": "tax_rate",
#       "active": true,
#       "created": 1578971621,
#       "description": null,
#       "display_name": "Tax Rate",
#       "inclusive": false,
#       "jurisdiction": null,
#       "livemode": false,
#       "metadata": {
#       },
#       "percentage": 10.0
#     }
#   ],
#   "discount": null,
#   "ended_at": null,
#   "invoice_customer_balance_settings": {
#     "consume_applied_balance_on_void": true
#   },
#   "items": {
#     "object": "list",
#     "data": [
#       {
#         "id": "si_GXlNni5cJDyDti",
#         "object": "subscription_item",
#         "billing_thresholds": null,
#         "created": 1578971625,
#         "metadata": {
#         },
#         "plan": {
#           "id": "plan_GXlNWMKQvQVlHP",
#           "object": "plan",
#           "active": true,
#           "aggregate_usage": null,
#           "amount": 5000,
#           "amount_decimal": "5000",
#           "billing_scheme": "per_unit",
#           "created": 1578971621,
#           "currency": "jpy",
#           "interval": "month",
#           "interval_count": 1,
#           "livemode": false,
#           "metadata": {
#           },
#           "nickname": null,
#           "product": "prod_GXlNLNEq2tvinD",
#           "tiers": null,
#           "tiers_mode": null,
#           "transform_usage": null,
#           "trial_period_days": null,
#           "usage_type": "licensed"
#         },
#         "quantity": 1,
#         "subscription": "sub_GXlNu35gDwcliZ",
#         "tax_rates": [

#         ]
#       }
#     ],
#     "has_more": false,
#     "total_count": 1,
#     "url": "/v1/subscription_items?subscription=sub_GXlNu35gDwcliZ"
#   },
#   "latest_invoice": "in_1G0fqfCmti5jpytUaHFbzPFn",
#   "livemode": false,
#   "metadata": {
#   },
#   "next_pending_invoice_item_invoice": null,
#   "pending_invoice_item_interval": null,
#   "pending_setup_intent": null,
#   "plan": {
#     "id": "plan_GXlNWMKQvQVlHP",
#     "object": "plan",
#     "active": true,
#     "aggregate_usage": null,
#     "amount": 5000,
#     "amount_decimal": "5000",
#     "billing_scheme": "per_unit",
#     "created": 1578971621,
#     "currency": "jpy",
#     "interval": "month",
#     "interval_count": 1,
#     "livemode": false,
#     "metadata": {
#     },
#     "nickname": null,
#     "product": "prod_GXlNLNEq2tvinD",
#     "tiers": null,
#     "tiers_mode": null,
#     "transform_usage": null,
#     "trial_period_days": null,
#     "usage_type": "licensed"
#   },
#   "quantity": 1,
#   "schedule": "sub_sched_1G0fqfCmti5jpytUPM2cabvW",
#   "start_date": 1578971625,
#   "status": "active",
#   "tax_percent": 10.0,
#   "trial_end": null,
#   "trial_start": null
# }
# ====================================================================================================
# subscription.start_date
# 1578971625
# 2020-01-14 12:13:45 +0900
# subscription.cancel_at
# 1581650025
# 2020-02-14 12:13:45 +0900
# subscription.cancel_at - subscription.start_date
# 2678400