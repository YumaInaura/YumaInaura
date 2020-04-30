# receive keyword args method
def foo(x:, y:)
  p x
  p y
end

# OK
# Pass keyword args
foo(x: "x", y: "y")

# OK
# Pass hash but convert as keyword args explicity
foo(**{x: "x", y: "y"})

# OK
# Pass hash but convert as keyword args explicity
hash = {x: "x", y: "y"}
foo(**hash)

# NG
# Pass Hash Args
# warning: Using the last argument as keyword parameters is deprecated; maybe ** should be added to the call
foo({x: "x", y: "y"})


# Receive hash method
def bar(h = {})
  p h[:x]
  p h[:y]
end

# OK
bar(x: "x", y: "y")

# OK
bar({ x: "x", y: "y" })
