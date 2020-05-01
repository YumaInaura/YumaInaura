# Ruby 2.7

# to_hash method not implemented class
class ToHashNotImplementedUser
  def initialize(name:, age:)
    @name = name
    @age = age
  end
end

# to_hash method implemented class
class ToHashImplementedUser
  def initialize(name:, age:)
    @name = name
    @age = age
  end

  def to_hash
    {
      name: @name,
      age: @age
    }
  end
end

def show_args(*args, **keyword_args)
  puts "args: #{args}"
  puts "keyword_args: #{keyword_args}"
end


# ---------------------------
# ToHashNotImplementedUser Case
# ---------------------------

to_hash_not_implemented_bob = ToHashNotImplementedUser.new(name: "Bob", age: 30)

show_args(to_hash_not_implemented_bob)
# Receives as *args
#
#   args: [#<ToHashNotImplementedUser:0x00007fe7f708b038 @name="Bob", @age=30>]
#   keyword_args: {}


# ---------------------------
# ToHashImplementedUser Case
# ---------------------------

to_hash_implemented_alice = ToHashImplementedUser.new(name: "Alice", age: 20)

show_args(to_hash_implemented_alice)
# Receives as *keyword_args
#
# warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
#
# args: []
# keyword_args: {:name=>"Alice", :age=>20}

show_args(**to_hash_implemented_alice)
# Receives as *keyword_args
#
# No Warning
#
#   keyword_args: {:name=>"Alice", :age=>20}
#   args: []

show_args(to_hash_implemented_alice, **{})
# Receives as *args
#
# Explicity pass empty keyword args
#
#   args: [#<ToHashImplementedUser:0x00007fcf8d823db8 @name="Alice", @age=20>]
#   keyword_args: {}
