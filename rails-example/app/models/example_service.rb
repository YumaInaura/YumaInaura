require 'active_interaction'

class ExampleService < ActiveInteraction::Base
  float :x

  def execute
    x**2
  end
end