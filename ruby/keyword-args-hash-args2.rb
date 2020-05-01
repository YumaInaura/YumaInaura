# Ruby 2.7
# receive args and keyword args both with asterisk

def foo(*args, **kwargs)
  p args
  p kwargs
end

# Single arg
foo("YES")
# ["YES"]
# {}

# Multiple args
foo("AH", "WOW")
# ["AH", "WOW"]
# {}

# Array single args
foo(["WOW", "YEAH"])
# [["WOW", "YEAH"]]
# {}

# Array multiple args
foo(["SAY", "YES"], ["SAY", "NO"])
# [["SAY", "YES"], ["SAY", "NO"]]
# {}


# Args + Keyword Args
foo("SOME", "HOW", x: "X", y: "y")
# ["SOME", "HOW"]
# {:x=>"X", :y=>"y"}

# Only Keyword Args
foo(x: "X", y: "y")
# []
# {:x=>"X", :y=>"y"}

# Hash args
# warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
# *args will be empty!
# *kwargs takes hash!
foo({ x: "X", y: "y" })
# []
# {:x=>"X", :y=>"y"}

# Multiple args + Hash
# warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
foo("BIG", "CHANCE", { new: :age, will: :come })
# ["BIG", "CHANCE"]
# {:new=>:age, :will=>:come}

# Unable to use arg after keyword arg
# Syntax Error
# syntax error, unexpected ')'
#
# foo(x: "X", y: "y", "A")
