nodes = [1, 2, 3, 4, 5]

def determine_child_node(square, available_squares)
  available_squares.select { |node| node != square }
end

def minimax(square, depth=4, nodes)
  if depth == 0 || nodes.empty?
    p square
    return 'end'
  end
  nodes = determine_child_node(square, nodes)
  p nodes
  p square
  nodes.each do |child|
    minimax(child, depth - 1, nodes)
  end
end

minimax(1, 4, nodes)