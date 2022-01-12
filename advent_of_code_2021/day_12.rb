require 'yaml'
require 'pry'

raw_data = YAML.load_file('day_12.yml').split(" ")

data = raw_data.map { |connection| connection.split("-") }
all_nodes = data.flatten.uniq
start = data.select { |connection| connection.include?('start') }
start_nodes = start.flatten.uniq.select { |n| n != 'start' }
CONNECTIONS = data - start
SMALL_NODES = all_nodes.select { |node| node.upcase != node && node != 'end' && node != 'start' }

=begin
Q
- find the number of all valid routes from `start` to `end`
- rules:
  - route starts from `start`, ends at `end`
  - nodes with all uppercase letters can be visited multiple times
  - nodes with all lowercase letters can only be visited once
  - you cannot go from a node back to `start`
  - you cannot go from `end` to any other nodes, the route ends here.
  - implied: no connection between big nodes (all uppercase nodes).

- rules (p2):
  - route starts from `start`, ends at `end`
  - nodes with all uppercase letters can be visited multiple times
  - only one node with all lowercase letters can be visited twice
    - once a small node has been visited twice, all other small nodes can only be visited once
  - you cannot go from a node back to `start`
  - you cannot go from `end` to any other nodes, the route ends here.
  - implied: no connection between big nodes (all uppercase nodes).

D
- input: array
- output: array of routes, each route is an array with the name of nodes(including `start` and `end`)
- a hash marking whether a small node has been visited

A
- iterate through all connections starting from the node `start`, for each node on the other side of the connection:
  - if the node is `end`, add `end` to `path` and save a copy of `path` to `routes`, then remove current node (`end`)
  - if current node is a small node, visit_count + 1
    - add `current_node` to `path`, then iterate through and go to other possible nodes, for each node:
      - recursive_method
    - (all nodes has been explored) set current node visit_count - 1, and remove current node on `path`
  - if current node is a big node
    - add `current_node` to `path`, then iterate through and go to other possible nodes
      - recursive_method
    - (all nodes has been explored) remove current node on `path`

=end

def initialize_visit_record
  visit_record = {}
  SMALL_NODES.each { |node| visit_record[node] = 0 }
  visit_record
end

def find_valid_nodes(node, visit_record)
  possible_nodes = CONNECTIONS.select { |con| con.include?(node) }.map { |con| locate_other_end(node, con) }
  if visit_record.values.include?(2)
    visited_nodes = possible_nodes.select { |p_node| visit_record[p_node] == 1 || visit_record[p_node] == 2 }
  else
    visited_nodes = []
  end
  possible_nodes - visited_nodes
end

def locate_other_end(node, connection)
  (connection - [node]).join
end

def seek_route(node, path, counter, visit_record)
  if node == 'end'
    path << node
    counter += 1
    # binding.pry
    p path
    path.pop
    return counter
  end
  if SMALL_NODES.include?(node)
    visit_record[node] += 1
    path << node
    find_valid_nodes(node, visit_record).each do |valid_node|
      counter = seek_route(valid_node, path, counter, visit_record)
    end
    visit_record[node] -= 1
    path.pop
    return counter
  else
    path << node
    find_valid_nodes(node, visit_record).each do |valid_node|
      counter = seek_route(valid_node, path, counter, visit_record)
    end
    path.pop
    return counter
  end
end

visit_record = initialize_visit_record
counter = 0
path = []
start_nodes.each do |node|
  path << 'start'
  counter = seek_route(node, path, counter, visit_record)
  path = []
end
p counter