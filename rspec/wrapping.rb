# https://relishapp.com/rspec/rspec-mocks/v/3-9/docs/configuring-responses/wrapping-the-original-implementation


class You
  def self.say(message: )
    {
      message: message
    }
  end
end

RSpec.describe do
  it do
    expect(You.say(message: 'YES')).to eq({message: 'YES'})
  end

  it 'adds hash key value to method return hash' do
    allow(You).to receive(:say).and_wrap_original { |method, *args|
      method.call(*args).merge(hello: 'EVERYONE')
    }

    expect(You.say(message: 'YES')).to eq({message: 'YES', hello: 'EVERYONE'})
  end

  it 'overwrites method receives argument' do
    allow(You).to receive(:say).and_wrap_original { |method, *args|
      method.call(message: 'OH')
    }

    expect(You.say(message: 'YES')).to eq({message: 'OH'})
  end
end





class API
  def self.solve_for(x)
    (1..x).to_a
  end
end

RSpec.describe "and_wrap_original" do
  it "can be overridden for specific arguments using #with" do
    allow(API).to receive(:solve_for).and_wrap_original { |m, *args| m.call(*args).first(5) }
    allow(API).to receive(:solve_for).with(2).and_return([3])

    expect(API.solve_for(20)).to eq [1,2,3,4,5]
    expect(API.solve_for(2)).to eq [3]
  end
end


# $ rspec /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/rspec/wrapping.rb

# and_wrap_original
#   can be overridden for specific arguments using #with


#   is expected to eq {:message=>"YES"}
#   adds hash key value to method return hash
#   overwrites method receives argument

# Finished in 0.01419 seconds (files took 0.1395 seconds to load)
# 4 examples, 0 failures
