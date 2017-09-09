def preorder(tree)
  if tree[0].start_with?("葉")
    p(tree[0])
  end
  if tree[0].start_with?("節")
    preorder(tree[1])
    preorder(tree[2])
  end
end

node1 = ["節１", ["節２", ["葉A"], ["葉B"]], ["節３", ["葉C"], ["葉D"]]]
node2 = ["節１", ["節２", ["葉A"], ["節３", ["葉B"], ["葉C"]]], ["葉D"]]

preorder(node2)
