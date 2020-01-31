# Docs

# https://stripe.com/docs/billing/subscriptions/subscription-schedules
# https://stripe.com/docs/billing/subscriptions/subscription-schedules/use-cases
#
# https://stripe.com/docs/api/subscription_schedules/release
# https://support.stripe.com/questions/create-update-and-schedule-subscriptions


require 'stripe'

Stripe::api_key = ENV['STRIPE_SECRET_KEY']

product1 = Stripe::Product.create(name: "Gold plan #{rand(9999999999)}")
plan1 = Stripe::Plan.create(interval: 'day', currency: 'jpy', amount: 5000, product: product1.id, usage_type: 'licensed')

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
          ],
        prorate: false,
        default_tax_rates: [tax_rate],
      },
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
started_subscription = started_subscription_schedule.subscription

future_subscription_schedule = Stripe::SubscriptionSchedule.create(
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
          ],
        prorate: false,
        default_tax_rates: [tax_rate],
      },
    ],
  }
)



Stripe::SubscriptionSchedule.release(subscription_schedule.id)


subscription = Stripe::Subscription::create(
                 customer: customer.id,
                 default_payment_method: customer_payment_method.id,
                 items: [
                   { plan: plan.id }
                 ],
                 default_tax_rates: [tax_rate],
               )


subscription = Stripe::Subscription.create(
  {
    customer: customer.id,
    default_payment_method: customer_payment_method.id,
    items: [
      [
        { plan: plan1.id },
      ],
    ],
    prorate: false,
    default_tax_rates: [tax_rate],
  }
)

Stripe::Subscription.update(
  subscription.id,
    cancel_at: subscription.start_date + (1.5*24*60*60).to_i
)

Stripe::Subscription.update(
  subscription.id,
    cancel_at: subscription.start_date + (1.0*24*60*60).to_i
)

def update_subscription_schedule(base_subscription_schedule, end_from_start_date: )
  Stripe::SubscriptionSchedule.update(
    base_subscription_schedule.id,
    {
      end_behavior: 'cancel',
      phases: [
        {
          plans:
            [
              {
                plan:     base_subscription_schedule.phases[0].plans[0].plan,
                quantity: base_subscription_schedule.phases[0].plans[0].quantity
              },
            ],
          prorate: base_subscription_schedule.phases[0].prorate,
          default_tax_rates: [base_subscription_schedule.phases[0].default_tax_rates[0].id],
          start_date: base_subscription_schedule.phases[0].start_date,
          end_date: base_subscription_schedule.phases[0].start_date + end_from_start_date
        },
      ]
    }
  )
end


updated_subscription_schedule = update_subscription_schedule(subscription_schedule, end_from_start_date: (1.5*24*60*60).to_i)
updated_subscription_schedule = update_subscription_schedule(subscription_schedule, end_from_start_date: (1.0*24*60*60).to_i)

# STEP A
# Set subscrition canceled in one day, fit to plan natural cycle "day"
# It cancel Upcoming invoice
# It does not create proration adjustment or Upcoming invoice
#  Because subscription schedule cycle is smart finishing.
#
# Happens events kinds are ...
#  subscription_schedule.updated
updated_subscription_schedule = update_subscription_schedule(subscription_schedule, end_from_start_date: 24*60*60)
put_subscription_schedule(updated_subscription_schedule, 'UPDATED')

# STEP B
# Set subscrition canceled in half a day.
# Not wait natural plan interval end.
# It makes proration adjustment half price of plan in Upcoming invoice.
#
#   Unused time on Gold plan xxxxxxxx after 02 Jan 2020 / 1 / -¥2,500
#
#   Subtotal -¥2,500
#   Tax Rate (10%) -¥250
#   Total -¥2,750
#   Applied balance ¥2,750
#   Amount due ¥0
#
# Happens events kinds are ...
#   subscription_schedule.updated
#   customer.subscription.updated
#   invoiceitem.created
updated_subscription_schedule = update_subscription_schedule(subscription_schedule, end_from_start_date: 12*60*60)
put_subscription_schedule(updated_subscription_schedule, 'UPDATED')

# STEP C
# Set subscription back natural full ony day.
# It makes Upcoming Invoice plice zero
#
#   Time on Gold plan xxxxxxxx after 02 Jan 2020 / 1 / ¥2,500
#   Unused time on Gold plan xxxxxxxx after 02 Jan 2020 / 1 / -¥2,500
#
#   Subtotal ¥0
#   Tax Rate (10%) ¥0
#   Total ¥0
#   Amount due ¥0
updated_subscription_schedule = update_subscription_schedule(subscription_schedule, end_from_start_date: 24*60*60)
put_subscription_schedule(updated_subscription_schedule, 'UPDATED')

# STEP D
#   Gold plan 5392253972 / 1 / ¥5,000 / ¥5,000
#   Unused time on Gold plan 5392253972 after 02 Jan 2020 / 1 / -¥2,500
#
#   Subtotal ¥2,500
#   Tax Rate (10%) ¥250
#   Total ¥2,750
#   Amount due ¥2,750
updated_subscription_schedule = update_subscription_schedule(subscription_schedule, end_from_start_date: 36*60*60)
put_subscription_schedule(updated_subscription_schedule, 'UPDATED')


# <Stripe::SubscriptionSchedule:0x3fe0871c7d64 id=sub_sched_1Fw3jGCmti5jpytUUEx777Uw> JSON: {
#   "id": "sub_sched_1Fw3jGCmti5jpytUUEx777Uw",
#   "object": "subscription_schedule",
#   "canceled_at": null,
#   "completed_at": null,
#   "created": 1577871782,
#   "current_phase": null,
#   "customer": "cus_GSzieHd4SaZVwT",
#   "default_settings": {"billing_thresholds":null,"collection_method":"charge_automatically","default_payment_method":"pm_1Fw3jFCmti5jpytULIdFmhNG","default_source":null,"invoice_settings":{"days_until_due":null}},
#   "end_behavior": "release",
#   "livemode": false,
#   "metadata": {},
#   "phases": [
#     {"application_fee_percent":null,"billing_thresholds":null,"collection_method":null,"coupon":null,"default_payment_method":null,"default_tax_rates":[{"id":"txr_1Fw3jFCmti5jpytUP1Oxsrtz","object":"tax_rate","active":true,"created":1577871781,"description":null,"display_name":"Tax Rate","inclusive":false,"jurisdiction":null,"livemode":false,"metadata":{},"percentage":10.0}],"end_date":1579254182,"invoice_settings":null,"plans":[{"billing_thresholds":null,"plan":"plan_GSziwVjn9dBHSj","quantity":1,"tax_rates":[]}],"prorate":true,"start_date":1577914982,"tax_percent":10.0,"trial_end":null}
#   ],
#   "released_at": null,
#   "released_subscription": null,
#   "renewal_interval": null,
#   "revision": "sub_sched_rev_1Fw40FCmti5jpytUHLyhkRAl",
#   "status": "not_started",
#   "subscription": null
#}

# If set end_date and "cancel" behavior with single phase
updated_subscription_schedule = Stripe::SubscriptionSchedule.update(
  subscription_schedule.id,
  {
    end_behavior: 'cancel',
    phases: [
      {
        plans:
          [
            { plan: plan1.id, quantity: 1 },
          ],
          default_tax_rates: [tax_rate],
          start_date: phase_start_date,
          end_date: phase_end_date
      },
    ]
  }
)

# <Stripe::SubscriptionSchedule:0x3fe0871a6510 id=sub_sched_1Fw3jGCmti5jpytUUEx777Uw> JSON: {
#   "id": "sub_sched_1Fw3jGCmti5jpytUUEx777Uw",
#   "object": "subscription_schedule",
#   "canceled_at": null,
#   "completed_at": null,
#   "created": 1577871782,
#   "current_phase": null,
#   "customer": "cus_GSzieHd4SaZVwT",
#   "default_settings": {"billing_thresholds":null,"collection_method":"charge_automatically","default_payment_method":"pm_1Fw3jFCmti5jpytULIdFmhNG","default_source":null,"invoice_settings":{"days_until_due":null}},
#   "end_behavior": "cancel",
#   "livemode": false,
#   "metadata": {},
#   "phases": [
#     {"application_fee_percent":null,"billing_thresholds":null,"collection_method":null,"coupon":null,"default_payment_method":null,"default_tax_rates":[{"id":"txr_1Fw3jFCmti5jpytUP1Oxsrtz","object":"tax_rate","active":true,"created":1577871781,"description":null,"display_name":"Tax Rate","inclusive":false,"jurisdiction":null,"livemode":false,"metadata":{},"percentage":10.0}],"end_date":1579254182,"invoice_settings":null,"plans":[{"billing_thresholds":null,"plan":"plan_GSziwVjn9dBHSj","quantity":1,"tax_rates":[]}],"prorate":true,"start_date":1577914982,"tax_percent":10.0,"trial_end":null}
#   ],
#   "released_at": null,
#   "released_subscription": null,
#   "renewal_interval": null,
#   "revision": "sub_sched_rev_1Fw40eCmti5jpytUbsy70Mht",
#   "status": "not_started",
#   "subscription": null
# }

put_subscription_schedule(updated_subscription_schedule, 'UPDATED')


# If set end_date and "cancel" behavior with multiple phases
updated_subscription_schedule = Stripe::SubscriptionSchedule.update(
  subscription_schedule.id,
  {
    end_behavior: 'cancel',
    phases: [
      {
        plans:
          [
            { plan: plan1.id, quantity: 1 },
          ],
          default_tax_rates: [tax_rate],
          start_date: phase_start_date,
          end_date: phase_end_date
      },
      {
        plans:
          [
            { plan: plan1.id, quantity: 1 },
          ],
          default_tax_rates: [tax_rate],
          iterations: 3
      },
    ]
  }
)

put_subscription_schedule(updated_subscription_schedule, 'UPDATED')

# <Stripe::SubscriptionSchedule:0x3fce690d5224 id=sub_sched_1Fw4UqCmti5jpytUEUBuMWRm> JSON: {
#   "id": "sub_sched_1Fw4UqCmti5jpytUEUBuMWRm",
#   "object": "subscription_schedule",
#   "canceled_at": null,
#   "completed_at": null,
#   "created": 1577874732,
#   "current_phase": null,
#   "customer": "cus_GT0VlSwXWmmxbL",
#   "default_settings": {"billing_thresholds":null,"collection_method":"charge_automatically","default_payment_method":"pm_1Fw4UpCmti5jpytU9RefgCDT","default_source":null,"invoice_settings":{"days_until_due":null}},
#   "end_behavior": "cancel",
#   "livemode": false,
#   "metadata": {},
#   "phases": [
#     {"application_fee_percent":null,"billing_thresholds":null,"collection_method":null,"coupon":null,"default_payment_method":null,"default_tax_rates":[{"id":"txr_1Fw4UoCmti5jpytUIvY4dds0","object":"tax_rate","active":true,"created":1577874730,"description":null,"display_name":"Tax Rate","inclusive":false,"jurisdiction":null,"livemode":false,"metadata":{},"percentage":10.0}],"end_date":1579257132,"invoice_settings":null,"plans":[{"billing_thresholds":null,"plan":"plan_GT0VyGHcQ7u6vp","quantity":1,"tax_rates":[]}],"prorate":true,"start_date":1577917932,"tax_percent":10.0,"trial_end":null},
#     {"application_fee_percent":null,"billing_thresholds":null,"collection_method":null,"coupon":null,"default_payment_method":null,"default_tax_rates":[{"id":"txr_1Fw4UoCmti5jpytUIvY4dds0","object":"tax_rate","active":true,"created":1577874730,"description":null,"display_name":"Tax Rate","inclusive":false,"jurisdiction":null,"livemode":false,"metadata":{},"percentage":10.0}],"end_date":1579516332,"invoice_settings":null,"plans":[{"billing_thresholds":null,"plan":"plan_GT0VyGHcQ7u6vp","quantity":1,"tax_rates":[]}],"prorate":true,"start_date":1579257132,"tax_percent":10.0,"trial_end":null}
#   ],
#   "released_at": null,
#   "released_subscription": null,
#   "renewal_interval": null,
#   "revision": "sub_sched_rev_1Fw4XXCmti5jpytUazXmVcw2",
#   "status": "not_started",
#   "subscription": null
# }

