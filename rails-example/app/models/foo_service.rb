require 'active_interaction'

class FooService < ActiveInteraction::Base
  float :x

  def execute
    compose(ExampleService, x: x)
  end
end