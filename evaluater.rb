require 'minruby'

def evaluate(tree)
  case tree[0]
  when 'lit'
    tree[1]
  when '+'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left + right
  when '-'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left - right
  when '*'
    preorder(tree[1])
    preorder(tree[2])
  else
    preorder(tree[1])
    preorder(tree[2])
  end
end

str = gets

tree = minruby_parse(str)

answer = evaluate(tree)

['+', ['+', ['lit', '1'],['lit', '2']],['+', ['lit', '3'], ['lit', '4']]]
