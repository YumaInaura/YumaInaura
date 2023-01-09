require 'rails_helper'

RSpec.describe "examples/show", type: :view do
  before(:each) do
    @example = assign(:example, Example.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
