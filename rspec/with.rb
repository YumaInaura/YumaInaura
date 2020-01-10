# Doc
# https://relishapp.com/rspec/rspec-mocks/v/3-2/docs/setting-constraints/matching-arguments

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

describe 'deep conplexed case' do
  subject do
    SomeClass.call(
      'X',
      {
        y1: 'Y1',
        y2: rand(999_999).to_s,
        y3: rand(999_999),
        y4: {
          y4_1: [1,2,3],
          y4_2: [4,5,6],
          y4_3: [7,8,9],
        }
      },
      'Z'
    )
  end

  example 'complexed match' do
    expect(SomeClass).to receive(:call).with(
      'X',
      hash_including(
        y1: 'Y1',
        y2: (be_a String),
        y4: hash_including(
          y4_1: array_including(1, 3),
          y4_3: contain_exactly(9, 7, 8),
        )
      ),
      any_args
    )
    subject
  end
end

# $ rspec -fd /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/rspec/with.rb

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

# more conplexed case
#   complexed match

# Finished in 0.01357 seconds (files took 0.15283 seconds to load)
# 8 examples, 0 failures
