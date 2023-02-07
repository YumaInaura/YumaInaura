require 'rails_helper'

RSpec.describe FooService, type: :model do
  it do
    expect_any_instance_of(FooService).to receive(:compose).with(BarService)
    FooService.run!
  end
end
