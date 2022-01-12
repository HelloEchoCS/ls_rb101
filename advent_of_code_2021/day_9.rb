require 'yaml'
require 'pry'

parsed_data = YAML.load_file('day_9.yml').split(" ").map { |line| line.chars.map { |str| str.to_i } }

=begin
A
- iterate through all lines
  - iterate through each line
    - find adjacent numbers:
      - given a num, it's position is arr[y][x]
      - it's adjacent positions are: [y+1][x], [y-1][x], [y][x+1], [y][x-1]
      - group positions into an array, reject `nil` values
    - if current number is the lowest, add it to low_points
- calculate risk levels of all low points

=end

def find_low_points(arr)
  low_points = []
  arr.each_with_index do |line, y|
    line.each_with_index do |num, x|
      adj_pos = []
      up = arr[y-1][x]
      up = nil if y - 1 < 0
      left = arr[y][x-1]
      left = nil if x - 1 < 0
      right = arr[y][x+1]
      down = nil
      if y + 1 == arr.length
        down = nil
      else
        down = arr[y+1][x]
      end
      # binding.pry
      adj_pos = [up, down, left, right]
      adj_pos = adj_pos.select { |pos| pos != nil }
      low_points << [y, x] if lowest?(adj_pos, num)
    end
  end
  low_points
end

def find_adj_pos(arr, y, x)
  adj_pos = []
  up = [y-1, x]
  up = nil if y - 1 < 0
  left = [y, x-1]
  left = nil if x - 1 < 0
  down = nil
  if y + 1 == arr.length
    down = nil
  else
    down = [y+1, x]
  end
  right = nil
  if x + 1 == arr[0].length
    right = nil
  else
    right = [y, x+1]
  end
  adj_pos = [up, down, left, right]
  adj_pos = adj_pos.select { |pos| pos != nil }
end

def lowest?(arr, num)
  arr.include?(num) == false && (arr + [num]).min == num
end

def cal_risk_lvl(arr)
  arr.sum + arr.length
end

p low_points = find_low_points(parsed_data)

=begin
A
- find a low point
- find its adjacent points
- iterate through adj points
- if next - current == 1, find its adjacent points...

=end

def basin(parsed_data, pos, coordinates)
  y = pos[0]
  x = pos[1]
  if parsed_data[y][x] == 8
    return
  end
  adj_pos = find_adj_pos(parsed_data, y, x)
  adj_pos.each do |adj|
    if parsed_data[adj[0]][adj[1]] > parsed_data[y][x] && parsed_data[adj[0]][adj[1]] != 9
      coordinates << adj
      # p [parsed_data[adj[0]][adj[1]], parsed_data[y][x]]
      # binding.pry
      basin(parsed_data, adj, coordinates)
    end
  end
end


sizes = []
low_points.each do |low_p|
  coordinates = []
  basin(parsed_data, low_p, coordinates)
  sizes << coordinates.uniq.count + 1
end
multiply = 1
# p low_points[sizes.index(sizes.max(3)[1])]
sizes.max(3).each { |n| multiply *= n }
p multiply

# sizes = []
# coordinates = []
# basin(parsed_data, [61, 18], coordinates)
# binding.pry
# sizes << coordinates.uniq.count + 1