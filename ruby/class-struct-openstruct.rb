# Ruby 2.7
#
# https://dev.relatel.dk/blog/drat-ruby-has-a-double-splat/

# ------------------------
# Normal class
# receive some args
# ------------------------
class FooUser
  def initialize(name, age)
    @name = name
    @age = age
  end

  attr_reader :name, :age
end

alice = FooUser.new("Alice", 20)

p alice
#<FooUser:0x00007fb4d705d8e8 @name="Alice", @age=20>



# ------------------------
# Struct
# ------------------------
BarUser = Struct.new("BarUser", :name, :age)
bob = BarUser.new("Bob", 30)

p bob
#<struct Struct::BarUser name="Bob", age=30>




# ------------------------
# normal class
# receive keyword args
# ------------------------
class WowUser
  def initialize(name:, age:)
    @name = name
    @age = age
  end

  attr_reader :name, :age
end

carol = WowUser.new(name: "Carol", age: 40)

p carol
#<WowUser:0x00007f83cd017e00 @name="Carol", @age=40>


# ------------------------
# Open Struct
# Directly create instance
# ------------------------

require "ostruct"

david = OpenStruct.new(name: "David", age: 40)

p david
#<OpenStruct name="David", age=40>


# ------------------------
# Open Struct
# extend with Class
# ------------------------

require "ostruct"

class YeahUser < OpenStruct
end

eric = YeahUser.new(name: "Eric", age: 50)

p eric
#<OpenStruct name="David", age=40>
