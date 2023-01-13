require 'rails_helper'

RSpec.describe "exes/new", type: :view do
  before(:each) do
    assign(:ex, Ex.new(
      message: "MyString"
    ))
  end

  it "renders new ex form" do
    render

    assert_select "form[action=?][method=?]", exes_path, "post" do

      assert_select "input[name=?]", "ex[message]"
    end
  end
end
