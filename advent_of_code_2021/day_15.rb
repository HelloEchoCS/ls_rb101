require 'pry'

def expand_map(graph)
  max_x = 5 * graph[0].length
  max_y = 5 * graph.length
  new_graph = []
  max_y.times do
    line = []
    max_x.times do
      line << 0
    end
    new_graph << line
  end
  new_graph
end

def update_risks!(graph, new_graph)
  max_x = graph[0].length
  max_y = graph.length
  multiplier_y_max = 0
  9.times do |n|
    graph.each_with_index do |line, y|
      line.each_with_index do |node, x|
        # binding.pry
        multiplier_x = n - multiplier_y_max
        multiplier_y = multiplier_y_max
        while multiplier_x <= multiplier_y_max
          if node + n <= 9
            new_graph[y + multiplier_y * max_y][x + multiplier_x * max_x] = node + n
          else
            new_graph[y + multiplier_y * max_y][x + multiplier_x * max_x] = node + n - 9
          end
          multiplier_x += 1
          multiplier_y -= 1
        end
      end
    end
    if multiplier_y_max == 4
      next
    else
      multiplier_y_max += 1
    end
  end
end

graph = File.read("day_15.txt").split(/\n/).map { |line| line.chars.map { |char| char.to_i } }
new_graph = expand_map(graph)
update_risks!(graph, new_graph)
graph = new_graph

INF = 1.0 / 0
LEN_X = graph[0].length - 1
LEN_Y = graph.length - 1

CORNERS = {[0, 0] => [[1, 0], [0, 1]],
           [LEN_X, 0] => [[LEN_X - 1, 0], [LEN_X, 1]],
           [0, LEN_Y] => [[0, LEN_Y - 1], [1, LEN_Y]],
           [LEN_X, LEN_Y] => [[LEN_X - 1, LEN_Y], [LEN_X, LEN_Y - 1]]
}



def init_unvisited_nodes(graph)
  new_graph = []
  graph.each do |line|
    new_line = []
    line.each do |node|
      new_line << false
    end
    new_graph << new_line
  end
  new_graph
end

def init_graph(graph)
  new_graph = []
  graph.each do |line|
    new_line = []
    line.each do |node|
      new_line << [node, INF]
    end
    new_graph << new_line
  end
  new_graph[0][0][1] = 0
  new_graph
end

def find_adjs_on_borders(x, y, visited)
  adjs = [[0, y + 1], [0, y - 1], [1, y]] if x == 0
  adjs = [[x + 1, 0], [x - 1, 0], [x, 1]] if y == 0
  adjs = [[x, y + 1], [x, y - 1], [x - 1, y]] if x == LEN_X
  adjs = [[x + 1, y], [x - 1, y], [x, y - 1]] if y == LEN_Y
  adjs.select do |coordinate|
    visited[coordinate[1]][coordinate[0]] == false
  end
end

def find_adjs_other(x, y, visited)
  adjs = [[x - 1, y], [x, y + 1], [x, y - 1], [x + 1, y]]
  adjs.select do |coordinate|
    visited[coordinate[1]][coordinate[0]] == false
  end
end

def find_adjs_corner(x, y, visited)
  adjs = CORNERS[[x, y]]
  adjs.select do |coordinate|
    visited[coordinate[1]][coordinate[0]] == false
  end
end

def borders?(x, y)
  x == 0 || y == 0 || x == LEN_X || y == LEN_Y
end

def find_adjs(coordinate, visited)
  x = coordinate[0]
  y = coordinate[1]
  adjs = []
  return find_adjs_corner(x, y, visited) if CORNERS.keys.include?(coordinate)
  return find_adjs_on_borders(x, y, visited) if borders?(x, y)
  find_adjs_other(x, y, visited)
end

def mark_visted!(node, visited, pool)
  visited[node[1]][node[0]] = true
  pool.delete(node)
end

def shortest_path(graph, visited, coordinate, pool)
  # return if current_node == [LEN_X, LEN_Y]
  x = coordinate[0]
  y = coordinate[1]
  neighbors = find_adjs(coordinate, visited)
  neighbors.each do |node|
    neighbor = graph[node[1]][node[0]]
    # binding.pry
    if graph[y][x][1] + neighbor[0] < neighbor[1]
      neighbor[1] = graph[y][x][1] + neighbor[0]
    end
    pool[node] = neighbor[1]
  end
  mark_visted!(coordinate, visited, pool)
end

# def find_next_node(graph, visited)
#   smallest = INF
#   smallest_coordinate = []
#   graph.each_with_index do |line, y|
#     line.each_with_index do |node, x|
#       if visited[y][x] == false && node[1] < smallest
#         smallest = node[1]
#         smallest_coordinate = [x, y]
#       end
#     end
#   end
#   smallest_coordinate
# end

def find_next_node(graph, pool)
  smallest = INF
  smallest_node = []
  pool.each do |node, value|
    if value < smallest
      smallest = value
      smallest_node = node
    end
  end
  smallest_node
end

map = init_graph(graph)
visited = init_unvisited_nodes(graph)
pool = {}
current_node = [0, 0]
loop do
  shortest_path(map, visited, current_node, pool)
  current_node = find_next_node(map, pool)
  p pool.count
  # binding.pry
  break if visited[LEN_Y][LEN_X] == true
end
p map[LEN_Y][LEN_X]