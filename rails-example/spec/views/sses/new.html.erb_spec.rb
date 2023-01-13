require 'rails_helper'

RSpec.describe "sses/new", type: :view do
  before(:each) do
    assign(:ss, Ss.new())
  end

  it "renders new ss form" do
    render

    assert_select "form[action=?][method=?]", sses_path, "post" do
    end
  end
end
