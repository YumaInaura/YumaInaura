# https://docs.ruby-lang.org/ja/latest/method/Forwardable/i/delegate.html

require 'forwardable'

class Foo
  extend Forwardable

  def initialize
    @bar = Bar.new
  end

  delegate wow: :@bar
  delegate yeah: :@bar
end


class Bar
  def wow
    p "wow!"
  end

  def yeah
    p "yeah!"
  end
end

Foo.new.wow # wow!

Foo.new.yeah # yeah!