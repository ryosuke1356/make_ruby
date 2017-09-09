require "minruby"

def evaluate(tree, env)
  case tree[0]
  when "if"
    if evaluate(tree[1], env)
      evaluate(tree[2], env)
    else
      evaluate(tree[3], env)
    end
  when "lit"
    tree[1]
  when "+"
    evaluate(tree[1], env) + evaluate(tree[2], env)
  when "-"
    evaluate(tree[1], env) - evaluate(tree[2], env)
  when "*"
    evaluate(tree[1], env) * evaluate(tree[2], env)
  when "/"
    evaluate(tree[1], env) / evaluate(tree[2], env)
  when "=="
    evaluate(tree[1], env) == evaluate(tree[2], env)
  when "var_assign"
    env[tree[1]] = evaluate(tree[2], env)
  when "var_ref"
    env[tree[1]]
  when "stmts"
    i = 1
    last = nil
    while tree[i]
      last = evaluate(tree[i], env)
      i = i + 1
    end
    last
  when "func_call" # 仮の実装
    p(evaluate(tree[2], env))
  else
    pp(tree)
  end
end

str = minruby_load()

tree = minruby_parse(str)

env = {}
answer = evaluate(tree, env)


# when "%"
#   evaluate(tree[1])
#   evaluate(tree[2])
#   left % right
# when "**"
#   evaluate(tree[1])
#   evaluate(tree[2])
#   left ** right
# when ">"
#   evaluate(tree[1])
#   evaluate(tree[2])
#   left > right
# when "<"
#   evaluate(tree[1])
#   evaluate(tree[2])
#   left < right
