# Ruby 2.7
#
# https://dev.relatel.dk/blog/drat-ruby-has-a-double-splat/



# ------------------------
# Struct
# ------------------------
User = Struct.new("User", :name, :age)
alice = User.new("Alice", 30)

def foo(*args, **kwargs)
  Bar.new(*args, **kwargs).bar
end

class Bar
  def initialize
  end

  def bar(param)
    p param
  end
end

bar(alice)