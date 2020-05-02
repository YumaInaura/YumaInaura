#
# https://dev.relatel.dk/blog/drat-ruby-has-a-double-splat/


class Foo
  def self.bar(x:, y:)
    p x
    p y
  end
end

Foo.bar(x: "X", y: "Y")


