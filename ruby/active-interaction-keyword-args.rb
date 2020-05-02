require "active_interaction"

class ServiceClass < ActiveInteraction::Base
  string :x
  string :y

  def execute
    p x
    p y
  end
end

# OK
# Keyword args
ServiceClass.run!(x: "X1", y: "Y1")

# OK
# Convert Hash to keyword args
ServiceClass.run!(**{ x: "X2", y: "Y2" })

# OK
# Hash args
# No Warning happens
ServiceClass.run!({ x: "X3", y: "Y3" })

# OK
# Not Symbol string key
ServiceClass.run!({ "x" => "X4", "y" => "Y4" })

# OK
# Not symbol string key
# Convert Hash to keyword args
ServiceClass.run!(**{ "x" => "X5", "y" => "Y5" })


class Foo
  def initialize(x: , y:)
    @x = x
    @y = y
  end

  def run!
    p @x
    p @y
  end
end

# OK
# Keyword args
Foo.new(x: "XX1", y: "YY1").run!

# OK
# Convert Hash to keyword args
Foo.new(**{ x: "XX2", y: "YY2" }).run!

# OK
# Hash args
# warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
Foo.new({ x: "XX3", y: "YY3" }).run!

# NG
# Not Symbol string key
# ArgumentError
Foo.new({ "x" => "XX4", "y" => "YY4" }).run!

# OK
# Not symbol string key
# ArgumentError
Foo.new(**{ "x" => "XX5", "y" => "YY5" }).run!

