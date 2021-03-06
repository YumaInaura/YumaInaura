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

# No attach payment method
# customer_payment_method = Stripe::PaymentMethod.attach(payment_method.id, customer: customer.id)

customer = Stripe::Customer.retrieve(customer.id)

# Set start_date to immediately start schedule
subscription_schedule = Stripe::SubscriptionSchedule.create(
  {
    customer: customer.id,
    start_date: 'now',
    phases: [
      {
        plans:
          [
            {plan: plan.id, quantity: 1},
          ],
          default_payment_method: payment_method.id,
          default_tax_rates: [tax_rate],
      },
    ],
  }
)

latest_invoice = Stripe::Subscription.retrieve(id: subscription_schedule.subscription, expand: ['latest_invoice']).latest_invoice

begin
  Stripe::Invoice.pay(latest_invoice.id)
rescue Stripe::CardError => exception
  puts exception.message
  # Stripe::CardError: Cannot charge a customer that has no active card
end

latest_invoice = Stripe::Subscription.retrieve(id: subscription_schedule.subscription, expand: ['latest_invoice']).latest_invoice

payment_intent = Stripe::PaymentIntent.retrieve(latest_invoice.payment_intent)

puts '=' * 100
puts "INVOICE"
puts '-' * 100
puts latest_invoice


puts '=' * 100
puts "PAYMENT INTENT"
puts '-' * 100
puts payment_intent

puts '=' * 100
puts "You can See in Dash boards"
puts '-' * 100
puts "https://dashboard.stripe.com/test/subscription_schedules/#{subscription_schedule.id}"
puts "https://dashboard.stripe.com/test/subscriptions/#{subscription_schedule.subscription}"
puts "https://dashboard.stripe.com/test/invoices/#{latest_invoice.id}"

# $ STRIPE_SECRET_KEY=sk_test_xxx ruby ~/y/stripe/invoice-failure-subscription-schedule.rb
# Cannot charge a customer that has no active card
# ====================================================================================================
# INVOICE
# ----------------------------------------------------------------------------------------------------
# {
#   "id": "in_1G27vXCmti5jpytUKjNPvSEs",
#   "object": "invoice",
#   "account_country": "JP",
#   "account_name": "yumainaura",
#   "amount_due": 1100,
#   "amount_paid": 0,
#   "amount_remaining": 1100,
#   "application_fee_amount": null,
#   "attempt_count": 1,
#   "attempted": true,
#   "auto_advance": true,
#   "billing_reason": "subscription_create",
#   "charge": null,
#   "collection_method": "charge_automatically",
#   "created": 1579317887,
#   "currency": "jpy",
#   "custom_fields": null,
#   "customer": "cus_GZGSZ0GhDJaQJk",
#   "customer_address": null,
#   "customer_email": null,
#   "customer_name": null,
#   "customer_phone": null,
#   "customer_shipping": null,
#   "customer_tax_exempt": "none",
#   "customer_tax_ids": [

#   ],
#   "default_payment_method": null,
#   "default_source": null,
#   "default_tax_rates": [
#     {
#       "id": "txr_1G27vUCmti5jpytUyNK9MbxD",
#       "object": "tax_rate",
#       "active": true,
#       "created": 1579317884,
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
#   "description": null,
#   "discount": null,
#   "due_date": null,
#   "ending_balance": 0,
#   "footer": null,
#   "hosted_invoice_url": "https://pay.stripe.com/invoice/invst_UxerJurenn1Cw4pFghbiaVxnIl",
#   "invoice_pdf": "https://pay.stripe.com/invoice/invst_UxerJurenn1Cw4pFghbiaVxnIl/pdf",
#   "lines": {
#     "object": "list",
#     "data": [
#       {
#         "id": "sli_0616e17807f234",
#         "object": "line_item",
#         "amount": 1000,
#         "currency": "jpy",
#         "description": "1 × Gold plan 5102348880 (at ¥1,000 / month)",
#         "discountable": true,
#         "livemode": false,
#         "metadata": {
#         },
#         "period": {
#           "end": 1581996287,
#           "start": 1579317887
#         },
#         "plan": {
#           "id": "plan_GZGSaZUc6735b0",
#           "object": "plan",
#           "active": true,
#           "aggregate_usage": null,
#           "amount": 1000,
#           "amount_decimal": "1000",
#           "billing_scheme": "per_unit",
#           "created": 1579317883,
#           "currency": "jpy",
#           "interval": "month",
#           "interval_count": 1,
#           "livemode": false,
#           "metadata": {
#           },
#           "nickname": null,
#           "product": "prod_GZGSh0Su4l7pzQ",
#           "tiers": null,
#           "tiers_mode": null,
#           "transform_usage": null,
#           "trial_period_days": null,
#           "usage_type": "licensed"
#         },
#         "proration": false,
#         "quantity": 1,
#         "subscription": "sub_GZGS8XDtly5sH4",
#         "subscription_item": "si_GZGSz9VgJjuH9g",
#         "tax_amounts": [
#           {
#             "amount": 100,
#             "inclusive": false,
#             "tax_rate": "txr_1G27vUCmti5jpytUyNK9MbxD"
#           }
#         ],
#         "tax_rates": [

#         ],
#         "type": "subscription",
#         "unique_id": "il_1G27vXCmti5jpytUd3Hi7GAn"
#       }
#     ],
#     "has_more": false,
#     "total_count": 1,
#     "url": "/v1/invoices/in_1G27vXCmti5jpytUKjNPvSEs/lines"
#   },
#   "livemode": false,
#   "metadata": {
#   },
#   "next_payment_attempt": null,
#   "number": "5DF27B15-0001",
#   "paid": false,
#   "payment_intent": "pi_1G27vYCmti5jpytUh2JcpXp6",
#   "period_end": 1579317887,
#   "period_start": 1579317887,
#   "post_payment_credit_notes_amount": 0,
#   "pre_payment_credit_notes_amount": 0,
#   "receipt_number": null,
#   "starting_balance": 0,
#   "statement_descriptor": null,
#   "status": "open",
#   "status_transitions": {
#     "finalized_at": 1579317888,
#     "marked_uncollectible_at": null,
#     "paid_at": null,
#     "voided_at": null
#   },
#   "subscription": "sub_GZGS8XDtly5sH4",
#   "subtotal": 1000,
#   "tax": 100,
#   "tax_percent": 10.0,
#   "total": 1100,
#   "total_tax_amounts": [
#     {
#       "amount": 100,
#       "inclusive": false,
#       "tax_rate": "txr_1G27vUCmti5jpytUyNK9MbxD"
#     }
#   ],
#   "webhooks_delivered_at": null
# }
# ====================================================================================================
# PAYMENT INTENT
# ----------------------------------------------------------------------------------------------------
# {
#   "id": "pi_1G27vYCmti5jpytUh2JcpXp6",
#   "object": "payment_intent",
#   "amount": 1100,
#   "amount_capturable": 0,
#   "amount_received": 0,
#   "application": null,
#   "application_fee_amount": null,
#   "canceled_at": null,
#   "cancellation_reason": null,
#   "capture_method": "automatic",
#   "charges": {
#     "object": "list",
#     "data": [

#     ],
#     "has_more": false,
#     "total_count": 0,
#     "url": "/v1/charges?payment_intent=pi_1G27vYCmti5jpytUh2JcpXp6"
#   },
#   "client_secret": "pi_1G27vYCmti5jpytUh2JcpXp6_secret_4WoOHxA8JRDIF50hViRA1duI6",
#   "confirmation_method": "automatic",
#   "created": 1579317888,
#   "currency": "jpy",
#   "customer": "cus_GZGSZ0GhDJaQJk",
#   "description": "Invoice 5DF27B15-0001",
#   "invoice": "in_1G27vXCmti5jpytUKjNPvSEs",
#   "last_payment_error": null,
#   "livemode": false,
#   "metadata": {
#   },
#   "next_action": null,
#   "on_behalf_of": null,
#   "payment_method": null,
#   "payment_method_options": {
#     "card": {
#       "installments": null,
#       "request_three_d_secure": "automatic"
#     }
#   },
#   "payment_method_types": [
#     "card"
#   ],
#   "receipt_email": null,
#   "review": null,
#   "setup_future_usage": null,
#   "shipping": null,
#   "source": null,
#   "statement_descriptor": null,
#   "statement_descriptor_suffix": null,
#   "status": "requires_payment_method",
#   "transfer_data": null,
#   "transfer_group": null
# }
# ====================================================================================================
# You can See in Dash boards
# ----------------------------------------------------------------------------------------------------
# https://dashboard.stripe.com/test/subscription_schedules/sub_sched_1G27vXCmti5jpytU4cIDMnpV
# https://dashboard.stripe.com/test/subscriptions/sub_GZGS8XDtly5sH4
# https://dashboard.stripe.com/test/invoices/in_1G27vXCmti5jpytUKjNPvSEs
