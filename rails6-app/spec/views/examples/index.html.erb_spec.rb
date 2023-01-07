require 'rails_helper'

RSpec.describe "examples/index", type: :view do
  before(:each) do
    assign(:examples, [
      Example.create!(),
      Example.create!()
    ])
  end

  it "renders a list of examples" do
    render
  end
end
