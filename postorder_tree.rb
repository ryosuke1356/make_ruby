def postorder(tree)
    p(tree[0])
  if tree[0].start_with?("節")
    postorder(tree[1])
    postorder(tree[2])
  end
end

node1 = [["節３", ["葉C"], ["葉D"]], ["節２", ["葉A"], ["葉B"]], "節１"]

postorder(node1)
