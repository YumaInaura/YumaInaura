require 'rails_helper'

RSpec.describe "sses/index", type: :view do
  before(:each) do
    assign(:sses, [
      Ss.create!(),
      Ss.create!()
    ])
  end

  it "renders a list of sses" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
