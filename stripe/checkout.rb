# Docs

# https://stripe.com/docs/payments/checkout/collecting

# Code

require 'stripe'

Stripe::api_key = ENV['STRIPE_SECRET_KEY']

checkout_session = Stripe::Checkout::Session.create(
  payment_method_types: ["card"],
  mode: "setup",
  # customer_email: "",
  # client_reference_id: "",
  success_url: "http://example.com",
  cancel_url: "http://example.com",
)

# customer = Stripe::Customer.create
#
# checkout_session = Stripe::Checkout::Session.create(
#  payment_method_types: ["card"],
#  mode: "setup",
#  customer: customer.id
#   success_url: "http://example.com",
#   cancel_url: "http://example.com",
# )

# Exception: Stripe::InvalidRequestError: You can not pass a `customer` in setup mode.

puts checkout_session

# e.g
#
# {
#   "id": "cs_test_nSeAmaYPHYg3uYoJr0AGc8KDPWLX2SnW5ESdiSiNpIwkwb7QjoLBdcUZ",
#   "object": "checkout.session",
#   "billing_address_collection": null,
#   "cancel_url": "http://example.com",
#   "client_reference_id": null,
#   "customer": null,
#   "customer_email": null,
#   "display_items": [

#   ],
#   "livemode": false,
#   "locale": null,
#   "metadata": {
#   },
#   "mode": "setup",
#   "payment_intent": null,
#   "payment_method_types": [
#     "card"
#   ],
#   "setup_intent": "seti_1GDl7YCmti5jpytU0I0ByfjD",
#   "submit_type": null,
#   "subscription": null,
#   "success_url": "http://example.com"
# }



puts <<~HTML
<script src="https://js.stripe.com/v3/"></script>

<script>

var stripe = Stripe('#{ENV['STRIPE_PUBLIC_KEY']}');

stripe.redirectToCheckout({
  // Make the id field from the Checkout Session creation API response
  // available to this file, so you can provide it as parameter here
  // instead of the {{CHECKOUT_SESSION_ID}} placeholder.
  sessionId: '#{checkout_session.id}'
}).then(function (result) {
  // If `redirectToCheckout` fails due to a browser or network
  // error, display the localized error message to your customer
  // using `result.error.message`.
});

</script>
HTML

# e.g
#
# Save this html file in your machine and access
#
# <script src="https://js.stripe.com/v3/"></script>
#
# <script>
#
# var stripe = Stripe('pk_test_wxxxxxxxxxxxxxxxxxxxxxx');
#
# stripe.redirectToCheckout({
#   // Make the id field from the Checkout Session creation API response
#   // available to this file, so you can provide it as parameter here
#   // instead of the {{CHECKOUT_SESSION_ID}} placeholder.
#   sessionId: 'cs_test_nSeAmaYPHYg3uYoJr0AGc8KDPWLX2SnW5ESdiSiNpIwkwb7QjoLBdcUZ'
# }).then(function (result) {
#   // If `redirectToCheckout` fails due to a browser or network
#   // error, display the localized error message to your customer
#   // using `result.error.message`.
# });
#
# </script>

# Redirect to URL example
# https://checkout.stripe.com/pay/cs_test_fRmOtv2TQjhfo1WmVXCxw68tlckFz6KiIUi2EwvHTACynBckPrfu98L1#fidkdWxOYHwnPyd1blpxYHZxWnJhVDRvd1B3bHRzY2xWSF9ycUJAUVFfZzU1dU9tNkJRTTMnKSd3YGNgd3dgd0p3bGJsayc%2Fa3BpaSknaGxhdic%2FfidicGxhJz8nS0QnKSdocGxhJz8nYzRhMWNnPDQoMGc1NygxPWNmKGc0PDUoNGRjMGFnPTQwMWQwJykndmxhJz8nNTNnMTcxZDMoNzE2MCgxMzwwKDwzY2coYTZgYzM0MjM1ZDU1J3gpJ2dgcWR2Jz9eWHgl
