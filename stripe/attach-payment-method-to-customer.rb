# Docs


require 'stripe'

Stripe::api_key = ENV['STRIPE_SECRET_KEY']

customer = Stripe::Customer.create

puts customer.id

100.times do |i|
  payment_method = Stripe::PaymentMethod.create(type: 'card', card: { number: '4242424242424242', exp_year: 2030, exp_month: 01})
  Stripe::PaymentMethod.attach(payment_method.id, customer: customer.id)

  puts i
  puts payment_method.id
end

Stripe::PaymentMethod.list(customer: customer.id, type: "card")

# e.g
# => #<Stripe::ListObject:0x3ffdc9a1b0ec> JSON: {
#   "object": "list",
#   "data": [
#     {"id":"pm_1GJ8aACmti5jpytUPXOhR2el","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371982,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a9Cmti5jpytUWeROY3bO","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371981,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a8Cmti5jpytUUFkrKZJ6","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371980,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a7Cmti5jpytUVuKYPWQL","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371979,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a6Cmti5jpytUCqWMO4i2","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371978,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a5Cmti5jpytUT5JyxJzJ","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371977,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a4Cmti5jpytUDl4a9frK","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit",...skipping...
# "generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371979,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a6Cmti5jpytUCqWMO4i2","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371978,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a5Cmti5jpytUT5JyxJzJ","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371977,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a4Cmti5jpytUDl4a9frK","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371976,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a3Cmti5jpytUcXobLAxC","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371975,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a2Cmti5jpytUSPg43cet","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371974,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"},
#     {"id":"pm_1GJ8a1Cmti5jpytUQRieESjv","object":"payment_method","billing_details":{"address":{"city":null,"country":null,"line1":null,"line2":null,"postal_code":null,"state":null},"email":null,"name":null,"phone":null},"card":{"brand":"visa","checks":{"address_line1_check":null,"address_postal_code_check":null,"cvc_check":null},"country":"US","exp_month":1,"exp_year":2030,"fingerprint":"3Dnj9E30BUfyFTcl","funding":"credit","generated_from":null,"last4":"4242","three_d_secure_usage":{"supported":true},"wallet":null},"created":1583371973,"customer":"cus_GqqFmnpkHh6bpB","livemode":false,"metadata":{},"type":"card"}
#   ],
#   "has_more": true,
#   "url": "/v1/payment_methods"
# }

