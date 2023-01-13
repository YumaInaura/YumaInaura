require 'rails_helper'

RSpec.describe "exes/show", type: :view do
  before(:each) do
    assign(:ex, Ex.create!(
      message: "Message"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Message/)
  end
end
