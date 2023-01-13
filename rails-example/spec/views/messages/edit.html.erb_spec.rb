require 'rails_helper'

RSpec.describe "messages/edit", type: :view do
  let(:message) {
    Message.create!()
  }

  before(:each) do
    assign(:message, message)
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(message), "post" do
    end
  end
end
