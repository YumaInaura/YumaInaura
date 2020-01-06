#! /usr/bin/env ruby

# Docs
# https://stripe.com/docs/api/subscriptions/update#update_subscription-prorate
# https://stripe.com/docs/api/subscriptions/create
# https://stripe.com/docs/billing/subscriptions/billing-cycle#prorations

require 'stripe'

# You Need
# `$ gem install activesupport` befure run ruby script
require 'active_support/core_ext'

Stripe::api_key = ENV['STRIPE_SECRET_KEY']

def create_subscription_and_cancel(name:, cancel_at_type:, prorate_in_update:)
  product1 = Stripe::Product.create(name: "Gold plan #{rand(9999999999)}")
  plan1 = Stripe::Plan.create(interval: 'month', currency: 'jpy', amount: 980, product: product1.id, usage_type: 'licensed')

  tax_rate = Stripe::TaxRate.create(display_name: 'Tax Rate', percentage: 10.0, inclusive: false)
  customer = Stripe::Customer.create
  payment_method = Stripe::PaymentMethod.create(type: 'card', card: { number: '4242424242424242', exp_year: 2030, exp_month: 01})
  customer_payment_method = Stripe::PaymentMethod.attach(payment_method.id, customer: customer.id)

  subscription = Stripe::Subscription.create(
    {
      customer: customer.id,
      default_payment_method: customer_payment_method.id,
      items: [
        [
          { plan: plan1.id },
        ],
      ],
      # You can not give persistence "prorate" property to Subscription
      # It property will not used in update this Subscription
      # prorate: false,
      default_tax_rates: [tax_rate],
    }
  )

  cancel_at = if cancel_at_type == :natural_cycle_end
                subscription.current_period_end
              elsif cancel_at_type == :natural_cycle_end_plus
                Time.at(subscription.current_period_end).since(1.month).to_i
              elsif cancel_at_type == :since_current_period_end
                Time.at(subscription.current_period_end).since(1.day).to_i
              elsif cancel_at_type == :ago_current_period_end
                Time.at(subscription.current_period_end).ago(1.day).to_i
              else
                raise
              end

  updated_subscription = Stripe::Subscription.update(
    subscription.id,
      cancel_at: cancel_at,
      # You need give prorate property as "true" with cancel_at
      # when in update not in create
      prorate: prorate_in_update
  )

  puts
  puts '=' * 100
  puts "#{name} SUBSCRIPTION"
  puts '-' * 100
  if ENV['VERBOSE']
    puts '-' * 100
    puts updated_subscription
  end

  begin
    upcoming_invoice = Stripe::Invoice.upcoming(customer: updated_subscription.customer)
    puts 'Upcoming Invoice'
    puts "subtotal: #{upcoming_invoice.subtotal}"
    puts "tax: #{upcoming_invoice.tax}"
    puts "total: #{upcoming_invoice.total}"
  rescue Stripe::InvalidRequestError => e
    puts e.message
  end

  puts "prorate_in_update: #{prorate_in_update}"
  puts "cancel_at_type: #{cancel_at_type}"
  puts "cancel_at: #{updated_subscription.cancel_at} ( #{Time.at(updated_subscription.cancel_at)} ) "

  if ENV['VERBOSE']
    puts '-' * 100
    puts upcoming_invoice
  end

  puts '-' * 100
  puts "https://dashboard.stripe.com/test/subscriptions/#{subscription.id}"

  updated_subscription
end

# Cancel_at Natural cycle end
# No upcoming invoice even if prorate: :true
create_subscription_and_cancel(name: 'A', cancel_at_type: :natural_cycle_end, prorate_in_update: true)
create_subscription_and_cancel(name: 'B', cancel_at_type: :natural_cycle_end, prorate_in_update: false)

# Cancel_at Natural cycle but not current cycle, cancel at next cycle end
# Both occurs Upcoming Invoice
# It seems to ignore "prorate: :false" property that right?
create_subscription_and_cancel(name: 'C', cancel_at_type: :natural_cycle_end_plus, prorate_in_update: true)
create_subscription_and_cancel(name: 'D', cancel_at_type: :natural_cycle_end_plus, prorate_in_update: false)

# Cancel at before current period end
# When prorate true Then Upcoming Invoice occurs as "minus" amount
# It seems to behaves like "refund"
# When prorate false Then No Upcoming Invoice
create_subscription_and_cancel(name: 'E', cancel_at_type: :ago_current_period_end, prorate_in_update: true)
create_subscription_and_cancel(name: 'F', cancel_at_type: :ago_current_period_end, prorate_in_update: false)

# Cancel at after current period end
# Both occurs Upcoming Invoice
# It seems to ignore "prorate: :false" property that right?
create_subscription_and_cancel(name: 'G', cancel_at_type: :since_current_period_end, prorate_in_update: true)
create_subscription_and_cancel(name: 'H', cancel_at_type: :since_current_period_end, prorate_in_update: false)

