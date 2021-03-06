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

# def put_subscription_schedule_focused(subscription_schedule, message = nil)
#   puts '=' * 100
#   puts "subscription : #{subscription_schedule.subscription}"
#   puts "phase start_date: #{Time.at(subscription_schedule.phases[0].start_date)}"
#   puts "phase end_date: #{Time.at(subscription_schedule.phases[0].end_date)}"
# end

def put_subscription_schedule(subscription_schedule, message = nil)
  puts '=' * 100
  puts "Subscription Schedule"
  puts '-' * 100
  puts subscription_schedule
  puts '-' * 100
  puts "https://dashboard.stripe.com/test/subscription_schedules/#{subscription_schedule.id}"
end

def put_subscription(subscription, message = nil)
  puts '=' * 100
  puts "Subscription"
  puts '-' * 100
  puts subscription
  puts '-' * 100
  puts "https://dashboard.stripe.com/test/subscriptions/#{subscription.id}"
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
      }
    ],
  }
)

subscription = Stripe::Subscription.retrieve(subscription_schedule.subscription)

released_subscription_schedule = Stripe::SubscriptionSchedule.release(subscription_schedule.id)

released_subscription = Stripe::Subscription.retrieve(released_subscription_schedule.released_subscription)

# put_subscription_schedule(subscription_schedule)
put_subscription(subscription)
# put_subscription_schedule(released_subscription_schedule)
put_subscription(released_subscription)



# ====================================================================================================
# Subscription
# ----------------------------------------------------------------------------------------------------
# {
#   "id": "sub_GaKyPqfTwtNHPn",
#   "object": "subscription",
#   "application_fee_percent": null,
#   "billing_cycle_anchor": 1579565347,
#   "billing_thresholds": null,
#   "cancel_at": 1595290147,
#   "cancel_at_period_end": false,
#   "canceled_at": 1579565347,
#   "collection_method": "charge_automatically",
#   "created": 1579565347,
#   "current_period_end": 1582243747,
#   "current_period_start": 1579565347,
#   "customer": "cus_GaKyTAocGb2gPJ",
#   "days_until_due": null,
#   "default_payment_method": "pm_1G3AIpCmti5jpytU76vW6l7t",
#   "default_source": null,
#   "default_tax_rates": [
#     {
#       "id": "txr_1G3AIoCmti5jpytU7YMjU6jx",
#       "object": "tax_rate",
#       "active": true,
#       "created": 1579565346,
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
#         "id": "si_GaKykUpb4ECgmM",
#         "object": "subscription_item",
#         "billing_thresholds": null,
#         "created": 1579565348,
#         "metadata": {
#         },
#         "plan": {
#           "id": "plan_GaKyYKqtmLHt4g",
#           "object": "plan",
#           "active": true,
#           "aggregate_usage": null,
#           "amount": 5000,
#           "amount_decimal": "5000",
#           "billing_scheme": "per_unit",
#           "created": 1579565346,
#           "currency": "jpy",
#           "interval": "month",
#           "interval_count": 1,
#           "livemode": false,
#           "metadata": {
#             "traffic_gigabytes": "1.5"
#           },
#           "nickname": null,
#           "product": "prod_GaKyTsBRZCe0Ju",
#           "tiers": null,
#           "tiers_mode": null,
#           "transform_usage": null,
#           "trial_period_days": null,
#           "usage_type": "licensed"
#         },
#         "quantity": 1,
#         "subscription": "sub_GaKyPqfTwtNHPn",
#         "tax_rates": [

#         ]
#       }
#     ],
#     "has_more": false,
#     "total_count": 1,
#     "url": "/v1/subscription_items?subscription=sub_GaKyPqfTwtNHPn"
#   },
#   "latest_invoice": "in_1G3AIqCmti5jpytUjIhbQxwf",
#   "livemode": false,
#   "metadata": {
#   },
#   "next_pending_invoice_item_invoice": null,
#   "pending_invoice_item_interval": null,
#   "pending_setup_intent": null,
#   "pending_update": null,
#   "plan": {
#     "id": "plan_GaKyYKqtmLHt4g",
#     "object": "plan",
#     "active": true,
#     "aggregate_usage": null,
#     "amount": 5000,
#     "amount_decimal": "5000",
#     "billing_scheme": "per_unit",
#     "created": 1579565346,
#     "currency": "jpy",
#     "interval": "month",
#     "interval_count": 1,
#     "livemode": false,
#     "metadata": {
#       "traffic_gigabytes": "1.5"
#     },
#     "nickname": null,
#     "product": "prod_GaKyTsBRZCe0Ju",
#     "tiers": null,
#     "tiers_mode": null,
#     "transform_usage": null,
#     "trial_period_days": null,
#     "usage_type": "licensed"
#   },
#   "quantity": 1,
#   "schedule": "sub_sched_1G3AIpCmti5jpytU2esttruo",
#   "start_date": 1579565347,
#   "status": "active",
#   "tax_percent": 10.0,
#   "trial_end": null,
#   "trial_start": null
# }
# ----------------------------------------------------------------------------------------------------
# https://dashboard.stripe.com/test/subscriptions/sub_GaKyPqfTwtNHPn
# ====================================================================================================
# Subscription
# ----------------------------------------------------------------------------------------------------
# {
#   "id": "sub_GaKyPqfTwtNHPn",
#   "object": "subscription",
#   "application_fee_percent": null,
#   "billing_cycle_anchor": 1579565347,
#   "billing_thresholds": null,
#   "cancel_at": null,
#   "cancel_at_period_end": false,
#   "canceled_at": null,
#   "collection_method": "charge_automatically",
#   "created": 1579565347,
#   "current_period_end": 1582243747,
#   "current_period_start": 1579565347,
#   "customer": "cus_GaKyTAocGb2gPJ",
#   "days_until_due": null,
#   "default_payment_method": "pm_1G3AIpCmti5jpytU76vW6l7t",
#   "default_source": null,
#   "default_tax_rates": [
#     {
#       "id": "txr_1G3AIoCmti5jpytU7YMjU6jx",
#       "object": "tax_rate",
#       "active": true,
#       "created": 1579565346,
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
#         "id": "si_GaKykUpb4ECgmM",
#         "object": "subscription_item",
#         "billing_thresholds": null,
#         "created": 1579565348,
#         "metadata": {
#         },
#         "plan": {
#           "id": "plan_GaKyYKqtmLHt4g",
#           "object": "plan",
#           "active": true,
#           "aggregate_usage": null,
#           "amount": 5000,
#           "amount_decimal": "5000",
#           "billing_scheme": "per_unit",
#           "created": 1579565346,
#           "currency": "jpy",
#           "interval": "month",
#           "interval_count": 1,
#           "livemode": false,
#           "metadata": {
#             "traffic_gigabytes": "1.5"
#           },
#           "nickname": null,
#           "product": "prod_GaKyTsBRZCe0Ju",
#           "tiers": null,
#           "tiers_mode": null,
#           "transform_usage": null,
#           "trial_period_days": null,
#           "usage_type": "licensed"
#         },
#         "quantity": 1,
#         "subscription": "sub_GaKyPqfTwtNHPn",
#         "tax_rates": [

#         ]
#       }
#     ],
#     "has_more": false,
#     "total_count": 1,
#     "url": "/v1/subscription_items?subscription=sub_GaKyPqfTwtNHPn"
#   },
#   "latest_invoice": "in_1G3AIqCmti5jpytUjIhbQxwf",
#   "livemode": false,
#   "metadata": {
#   },
#   "next_pending_invoice_item_invoice": null,
#   "pending_invoice_item_interval": null,
#   "pending_setup_intent": null,
#   "pending_update": null,
#   "plan": {
#     "id": "plan_GaKyYKqtmLHt4g",
#     "object": "plan",
#     "active": true,
#     "aggregate_usage": null,
#     "amount": 5000,
#     "amount_decimal": "5000",
#     "billing_scheme": "per_unit",
#     "created": 1579565346,
#     "currency": "jpy",
#     "interval": "month",
#     "interval_count": 1,
#     "livemode": false,
#     "metadata": {
#       "traffic_gigabytes": "1.5"
#     },
#     "nickname": null,
#     "product": "prod_GaKyTsBRZCe0Ju",
#     "tiers": null,
#     "tiers_mode": null,
#     "transform_usage": null,
#     "trial_period_days": null,
#     "usage_type": "licensed"
#   },
#   "quantity": 1,
#   "schedule": null,
#   "start_date": 1579565347,
#   "status": "active",
#   "tax_percent": 10.0,
#   "trial_end": null,
#   "trial_start": null
# }
# ----------------------------------------------------------------------------------------------------
# https://dashboard.stripe.com/test/subscriptions/sub_GaKyPqfTwtNHPn
