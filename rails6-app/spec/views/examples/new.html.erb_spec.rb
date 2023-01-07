require 'rails_helper'

RSpec.describe "examples/new", type: :view do
  before(:each) do
    assign(:example, Example.new())
  end

  it "renders new example form" do
    render

    assert_select "form[action=?][method=?]", examples_path, "post" do
    end
  end
end
