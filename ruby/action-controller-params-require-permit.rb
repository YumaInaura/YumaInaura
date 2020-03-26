
# Execute with rails console

# Rails like Nested params with ActionController::Parameters instance
params = ActionController::Parameters.new(
  name: 'Alice',
  age: 22,
  contact: ActionController::Parameters.new(
    tel: 07011112222,
    email: 'user@example.com'
  )
)
# <ActionController::Parameters {"name"=>"Alice", "age"=>22, "contact"=><ActionController::Parameters {"tel"=>941921426, "email"=>"user@example.com"} permitted: false>} permitted: false>

# Ooops
# Args must be Array
params.require(:name, :age, :contact)
# ArgumentError: wrong number of arguments (given 3, expected 1)

# It works
params.require([:name, :age, :contact])
# => ["Alice", 22, <ActionController::Parameters {"tel"=>941921426, "email"=>"user@example.com"} permitted: false>]

# But with method chain
# How to permit multiple params Require and Permit ?

# require method returns values Array
# it is not work for generate permitted params
# because .permit .require both method does not change "params"
params.require([:name, :age, :contact])[2].permit(:tel, :email).require([:tel, :email])
# => [941921426, "user@example.com"]

# require method returns values Array
# Unable to use methods chain
params.require([:name, :age, :contact])[2].require([:tel, :email]).permit(:tel, :email)
# NoMethodError: undefined method `permit' for [941921426, "user@example.com"]:Array

# It is answer?
# User require and permit methods
# Without return values
# Without method chains
#
# And last execute permit!

params.require([:name, :age, :contact])
params[:contact].require([:tel, :email])

peritted_params = params.permit(:name, :age, contact: [:tel, :email])
# <ActionController::Parameters {"name"=>"Alice", "age"=>22, "contact"=><ActionController::Parameters {"tel"=>941921426, "email"=>"user@example.com"} permitted: true>} permitted: true>

# OR
params.permit(:name, :age, contact: [:tel, :email])
params.permit!
params
# => <ActionController::Parameters {"name"=>"Alice", "age"=>22, "contact"=><ActionController::Parameters {"tel"=>941921426, "email"=>"user@example.com"} permitted: true>} permitted: true>
[40] pry(main)>
