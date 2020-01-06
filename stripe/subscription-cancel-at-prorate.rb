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

[true, false].each do |prorate|
  [nil, 10.days, 20.days, 30.days, 40.days, 50.days, 60.days, 70.days].each do |cancel_at|
    product1 = Stripe::Product.create(name: "Gold plan #{rand(9999999999)}")
    plan1 = Stripe::Plan.create(interval: 'month', currency: 'jpy', amount: 1000, product: product1.id, usage_type: 'licensed')

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
        prorate: prorate,
        default_tax_rates: [tax_rate],
        cancel_at: (cancel_at ? Time.current.since(cancel_at).to_i : nil)
      }
    )


    puts '=' * 100
    if ENV['VERBOSE']
      puts '-' * 100
      puts subscription
    end

    puts "cancel_at: #{cancel_at}"
    puts "prorate: #{prorate}"


    customer_subscriptions_latest_invoice_id = Stripe::Customer.retrieve(customer.id).subscriptions.data[0].latest_invoice
    if customer_subscriptions_latest_invoice_id
      latest_subscription_invoice = Stripe::Invoice.retrieve(customer_subscriptions_latest_invoice_id)

      puts '-' * 100
      puts 'Invoice'
      puts "id: #{latest_subscription_invoice.id}"
      puts "subtotal: #{latest_subscription_invoice.subtotal}"
      puts "tax: #{latest_subscription_invoice.tax}"
      puts "total: #{latest_subscription_invoice.total}"
    else
      puts '-' * 100
      puts 'Invoice'
      puts 'None'
    end

    begin
      upcoming_invoice = Stripe::Invoice.upcoming(customer: subscription.customer)
      puts '-' * 100
      puts 'Upcoming Invoice'
      puts "subtotal: #{upcoming_invoice.subtotal}"
      puts "tax: #{upcoming_invoice.tax}"
      puts "total: #{upcoming_invoice.total}"
    rescue Stripe::InvalidRequestError => e
      puts e.message
    end

    puts '-' * 100
    puts "https://dashboard.stripe.com/test/subscriptions/#{subscription.id}"
  end
end
