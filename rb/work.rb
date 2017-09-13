require "minruby"

pp(minruby_parse("
ary = [1]
ary[0] = 42
"))
