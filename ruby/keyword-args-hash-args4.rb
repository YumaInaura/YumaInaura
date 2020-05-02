require "active_interaction"

class ServiceClass < ActiveInteraction::Base
  string :x
  string :y

  def execute
    p x
    p y
  end
end

# def foo(x:, y:)
#   p x
#   p y
# end

# foo({ "x" => "Y", "y" => "Y" })

# ArgumentError
# foo("x" => "Y", "y" => "Y")

