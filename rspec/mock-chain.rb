class User
  def initialize(name:, age: )
    @name = name
    @age = age
  end

  attr_reader :name, :age

  def book
    Book.new(author: name)
  end

  def book_number
    book.number
  end
end

class Book
  def initialize(author: nil)
    @author = author
    @number = Random.rand(999_999)
  end

  attr_reader :author, :number
end

require "rspec"

describe do
  context "No mock" do
    subject { user.book_number }

    let(:user) { User.new(name: "Alice", age: 20) }

    it do
      is_expected.to be_a Integer

      expect(user.name).to eq "Alice"
      expect(user.age).to eq 20
    end
  end

  context "NG mock" do
    subject { user.book_number }

    let(:user) { User.new(name: "Alice", age: 20) }

    it do
      # NoMethodError:
      # undefined method `number' for nil:NilClass
      allow(user).to receive(:book)

      is_expected.to be_a Integer

      expect(user.name).to eq "Alice"
      expect(user.age).to eq 20
    end
  end

  context "OK allow mock" do
    subject { user.book_number }

    let(:user) { User.new(name: "Alice", age: 20) }

    it do
      allow(user).to receive(:book).and_return Book.new

      is_expected.to be_a Integer

      expect(user.name).to eq "Alice"
      expect(user.age).to eq 20
    end
  end

  context "OK expect mock" do
    subject { user.book_number }

    let(:user) { User.new(name: "Alice", age: 20) }

    it do
      expect(user).to receive(:book).and_return Book.new

      is_expected.to be_a Integer

      expect(user.name).to eq "Alice"
      expect(user.age).to eq 20
    end
  end

  context "NG expect mock (method chain)" do
    subject { user.book_number }

    let(:user) { User.new(name: "Alice", age: 20) }

    it do
      # Failure/Error: expect(user.book).to receive(:number)
      #
      # (#<Book:0x00007fd5468f4aa8 @author="Alice", @number=415630>).number(*(any args))
      #     expected: 1 time with any arguments
      #     received: 0 times with any arguments
      expect(user.book).to receive(:number)

      is_expected.to be_a Integer
    end
  end

  context "OK expect mock (method chain)" do
    subject { user.book_number }

    let(:user) { User.new(name: "Alice", age: 20) }

    it do
      allow(user).to receive(:book).and_return Book.new
      expect(user.book).to receive(:number).and_call_original

      is_expected.to be_a Integer
    end
  end
end