class SomeClass
  def self.call(x, y, z)
  end
end

describe 'simple case' do
  subject do
    SomeClass.call('X','Y','Z')
  end

  it 'calls with exactly multiple args' do
    expect(SomeClass).to receive(:call).with('X', 'Y', 'Z')
    subject
  end
end

describe 'complexed case' do
  subject do
    SomeClass.call(
      'X',
      {
        y1: 'Y1',
        y2: 'Y2',
        y3: 'Y3',
      },
      'Z'
    )
  end

  example 'exactly match' do
    expect(SomeClass).to receive(:call).with(
      'X',
      {
        y1: 'Y1',
        y2: 'Y2',
        y3: 'Y3',
      },
      'Z'
    )
    subject
  end

  it 'partly match with hash in one arg' do
    expect(SomeClass).to receive(:call).with(
      'X',
      hash_including(
        y1: 'Y1',
        y2: 'Y2',
      ),
      'Z'
    )
    subject
  end
end

describe 'random value case' do
  subject do
    SomeClass.call(
      'X',
      {
        y1: 'Y1',
        y2: rand(999_999).to_s,
        y3: rand(999_999),
      },
      'Z'
    )
  end

  example 'fuzzy match on one arg' do
    expect(SomeClass).to receive(:call).with(
      'X',
      any_args,
      'Z'
    )
    subject
  end

  example 'exactly match and expect anything value' do
    expect(SomeClass).to receive(:call).with(
      'X',
      {
        y1: anything,
        y2: anything,
        y3: anything,
      },
      'Z'
    )
    subject
  end

  example 'exactly match and expect anything value' do
    expect(SomeClass).to receive(:call).with(
      'X',
      {
        y1: (be_a String),
        y2: (be_a String),
        y3: (be_a Integer),
      },
      'Z'
    )
    subject
  end

  example 'partly fuzzy match' do
    expect(SomeClass).to receive(:call).with(
      'X',
      hash_including(
        y1: 'Y1',
        y2: (be_a String),
      ),
      any_args
    )
    subject
  end
end


# $ rspec /Users/yumainaura/.ghq/github.com/YumaInaura/rspec/with.rb

# simple case
#   calls with exactly multiple args

# complexed case
#   exactly match
#   partly match with hash in one arg

# random value case
#   fuzzy match on one arg
#   exactly match and expect anything value
#   exactly match and expect anything value
#   partly fuzzy match

# Finished in 0.01604 seconds (files took 0.15593 seconds to load)
# 7 examples, 0 failures
