# https://www.ruby-lang.org/en/news/2019/12/12/separation-of-positional-and-keyword-arguments-in-ruby-3-0/

# https://medium.com/@sologoubalex/parameter-with-double-splat-operator-in-ruby-d944d234de34

# OK
# Pass keyword args to another method
def foo1(**kwargs)
  bar1(**kwargs)
end

def bar1(x:, y:)
  p x
  p y
end

foo1(x: "X1", y: "Y1")


# OK
# *args not used
def foo2(*args, **kwargs)
  bar2(*args, **kwargs)
end

def bar2(x:, y:)
  p x
  p y
end

foo2(x: "X2", y: "Y2")

# OK
# args used
# kwarss used
def foo3(*args, **kwargs)
  bar3(*args, **kwargs)
end

def bar3(hash, x:, y:)
  p hash[:a]
  p hash[:b]
  p x
  p y
end

foo3({a: "A3", b: "B3" }, **{ x: "X3", y: "Y3"})


# OK
def foo4(*args, **kwargs)
  bar4(*args, **kwargs)
end

def bar4(string, x:, y:)
  p string
  p x
  p y
end

foo4("A4", x: "X4", y: "Y4")

# NG
def foo5(*args, **kwargs)
  bar5(*args, **kwargs)
end

def bar5(string, hash)
  p string
  p hash[:x]
  p hash[:y]
end

# No Warning
bar5("A5",{ x: "X5", y: "Y5" })

# Warning
# warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
foo5("A5",{ x: "X5", y: "Y5" })



# OK
def foo6(*args)
  bar6(*args)
end

def bar6(string, hash)
  p string
  p hash[:x]
  p hash[:y]
end

foo6("A6",{ x: "X6", y: "Y6" })


