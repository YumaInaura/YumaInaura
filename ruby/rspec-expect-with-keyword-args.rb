require "rspec"

class Foo
  def self.run(x:, y:)
    Bar.run(x: x, y: y)
  end
end

class Bar
  def self.run(x:, y:)
    false
  end
end

describe do
  subject { Foo.run(x: "X", y: "Y") }

  describe do
    before do
      expect(Bar).to receive(:run).with(x: "X", y: "Y").and_return true
    end

    it { is_expected.to be true }
  end

  describe do
    let(:param) { { x: "X", y: "Y" } }

    before do
      expect(Bar).to receive(:run).with(**param).and_return true
    end

    it { is_expected.to be true }
  end

  describe do
    let(:param) { { "x" => "X", "y" => "Y" } }

    before do
      expect(Bar).to receive(:run).with(x: "X", y: "Y").and_return true
    end

    it { is_expected.to be true }
  end

end