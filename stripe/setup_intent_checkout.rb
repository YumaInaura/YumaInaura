# frozen_string_literal: true

# Docs

# https://stripe.com/docs/payments/checkout/collecting

# Code

require 'stripe'

Stripe.api_key = ENV['STRIPE_SECRET_KEY']

checkout_session = Stripe::Checkout::Session.create(
  payment_method_types: ['card'],
  mode: 'setup',
  success_url: 'http://example.com',
  cancel_url: 'http://example.com'
)

payment_method = Stripe::PaymentMethod.create(
  type: 'card',
  card: { number: '4242424242424242', exp_year: 2030, exp_month: 01}
)

# Stripe::InvalidRequestError:
# Some of the parameters you provided (payment_method) cannot be used when modifying a SetupIntent that was created by Checkout.
# You can try again without those parameters.

Stripe::SetupIntent.update(
  checkout_session.setup_intent,
  {payment_method: payment_method.id},
)
