require 'rails_helper'

RSpec.describe "sses/edit", type: :view do
  let(:ss) {
    Ss.create!()
  }

  before(:each) do
    assign(:ss, ss)
  end

  it "renders the edit ss form" do
    render

    assert_select "form[action=?][method=?]", ss_path(ss), "post" do
    end
  end
end
