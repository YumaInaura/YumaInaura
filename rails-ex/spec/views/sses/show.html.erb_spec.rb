require 'rails_helper'

RSpec.describe "sses/show", type: :view do
  before(:each) do
    assign(:ss, Ss.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
