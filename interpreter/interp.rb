require "minruby"

lenv = {}
genv = {
  "p" => ["builtin", "p"],
  "add" => ["builtin", "add"],
  "fizz_buzz" => ["builtin", "fizz_buzz"]
}

def evaluate(tree, genv, lenv)
  case tree[0]
  when "while"
    while evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    end
  when "if"
    if evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    else
      evaluate(tree[3], genv, lenv)
    end
  when "lit"
    tree[1]
  when "+"
    evaluate(tree[1], genv, lenv) + evaluate(tree[2], genv, lenv)
  when "-"
    evaluate(tree[1], genv, lenv) - evaluate(tree[2], genv, lenv)
  when "*"
    evaluate(tree[1], genv, lenv) * evaluate(tree[2], genv, lenv)
  when "/"
    evaluate(tree[1], genv, lenv) / evaluate(tree[2], genv, lenv)
  when "%"
    evaluate(tree[1], genv, lenv) % evaluate(tree[2], genv, lenv)
  when "**"
    evaluate(tree[1], genv, lenv) ** evaluate(tree[2], genv, lenv)
  when "=="
    evaluate(tree[1], genv, lenv) == evaluate(tree[2], genv, lenv)
  when ">"
    evaluate(tree[1], genv, lenv) > evaluate(tree[2], genv, lenv)
  when "<"
    evaluate(tree[1], genv, lenv) < evaluate(tree[2], genv, lenv)
  when "<="
    evaluate(tree[1], genv, lenv) <= evaluate(tree[2], genv, lenv)
  when "var_assign"
    lenv[tree[1]] = evaluate(tree[2], genv, lenv)
  when "var_ref"
    lenv[tree[1]]
  when "stmts"
    i = 1
    last = nil
    while tree[i]
      last = evaluate(tree[i], genv, lenv)
      i = i + 1
    end
    last
  when "func_def"
    genv[tree[1]] = ["user_defined", tree[2], tree[3]] # [ func_def, "関数名", [引数], [関数の中身] ]
  when "func_call"
    args = []
    i = 0
    while tree[i + 2]
      args[i] = evaluate(tree[i + 2], genv, lenv) # 全ての引数をargsに覚えさせる
      i = i + 1
    end
    mhd = genv[tree[1]] # => { "builtin", "p" }
    if mhd[0] == "builtin"
      minruby_call(mhd[1], args)
    else
      new_lenv = {}
      params = mhd[1]
      i = 0
      while params[i]
        new_lenv[params[i]] = args[i]
        i = i + 1
      end
      evaluate(mhd[2], genv, new_lenv)
    end
  else
    pp(tree)
  end
end

# ----------- 以下、独自の組み込み関数 -----------
def add(x, y)
  x + y
end

def fizz_buzz(count, div_x, div_y)
  i = 1
  while i < count
    if i % div_x == 0
      if i % div_y == 0
        p("FizzBuzz")
      else
        p("Fizz")
      end
    elsif i % div_y == 0
      p("Bazz")
    else
      p(i)
    end
    i = i + 1
  end
end
# ----------- 以上、独自の組み込み関数 -----------

str = minruby_load()

tree = minruby_parse(str)

answer = evaluate(tree, genv, lenv)
