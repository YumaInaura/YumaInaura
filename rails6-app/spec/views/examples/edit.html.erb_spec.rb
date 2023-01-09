require 'rails_helper'

RSpec.describe "examples/edit", type: :view do
  before(:each) do
    @example = assign(:example, Example.create!())
  end

  it "renders the edit example form" do
    render

    assert_select "form[action=?][method=?]", example_path(@example), "post" do
    end
  end
end
