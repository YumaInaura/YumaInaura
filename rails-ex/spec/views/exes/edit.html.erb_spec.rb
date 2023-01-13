require 'rails_helper'

RSpec.describe "exes/edit", type: :view do
  let(:ex) {
    Ex.create!(
      message: "MyString"
    )
  }

  before(:each) do
    assign(:ex, ex)
  end

  it "renders the edit ex form" do
    render

    assert_select "form[action=?][method=?]", ex_path(ex), "post" do

      assert_select "input[name=?]", "ex[message]"
    end
  end
end
