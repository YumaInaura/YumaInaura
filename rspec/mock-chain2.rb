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