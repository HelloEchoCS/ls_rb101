=begin
P
- calculate number of flashes after 100 steps given a initial state of octopus' energy levels.
- rules:
  - At the start of every step, increase each octopus's energy lvl by 1
  - then, any octopus with an energy lvl > 9 flashes, increase it's surrounding octopus's energy level by 1
  - 'surrounding' includes adjacent and diagonally adjacent octopus
  - each flashed octopus change it's energy level to 0, and no longer be affected until next step.

D
- input: array
- output: integer

A
- loop 100 times
  - increase all octopus energy lvl (EL) by 1
  - iterate through all the octopus, for each octopus (recursive method):
    - if it's EL == 0, go to the next octopus(return)
    - if it's EL > 9
      - set it's EL to 0
      - count_flashed + 1
      - find surrounding octopus, for each octopus
        - increase it's EL by 1 if its EL != 0
        - call the `recursive method` for this octopus
=end

require 'yaml'
require 'pry'
data = YAML.load_file('day_11.yml').split(" ").map { |line| line.chars.map { |p| p.to_i } }
LEN_X = data[0].length - 1
LEN_Y = data.length - 1

CORNERS = {[0, 0] => [[1, 0], [0, 1], [1, 1]],
           [LEN_X, 0] => [[LEN_X - 1, 0], [LEN_X, 1], [LEN_X - 1, 1]],
           [0, LEN_Y] => [[0, LEN_Y - 1], [1, LEN_Y], [1, LEN_Y - 1]],
           [LEN_X, LEN_Y] => [[LEN_X - 1, LEN_Y], [LEN_X, LEN_Y - 1], [LEN_X - 1, LEN_Y - 1]]
}

def find_adjs_on_borders(x, y)
  return [[0, y + 1], [0, y - 1], [1, y - 1], [1, y], [1, y + 1]] if x == 0
  return [[x + 1, 0], [x - 1, 0], [x + 1, 1], [x - 1, 1], [x, 1]] if y == 0
  return [[x, y + 1], [x, y - 1], [x - 1, y - 1], [x - 1, y], [x - 1, y + 1]] if x == LEN_X
  return [[x + 1, y], [x - 1, y], [x + 1, y - 1], [x - 1, y - 1], [x, y - 1]] if y == LEN_Y
end

def find_adjs_other(x, y)
  [[x - 1, y], [x - 1, y - 1], [x - 1, y + 1], [x, y + 1], [x, y - 1], [x + 1, y], [x + 1, y + 1], [x + 1, y - 1]]
end

def borders?(x, y)
  x == 0 || y == 0 || x == LEN_X || y == LEN_Y
end

def find_adjs(coordinate)
  x = coordinate[0]
  y = coordinate[1]
  adjs = []
  return CORNERS[coordinate] if CORNERS.keys.include?(coordinate)
  return find_adjs_on_borders(x, y) if borders?(x, y)
  find_adjs_other(x, y)
end

def recursive_octupus(map, coordinate, count_flashed)
  x = coordinate[0]
  y = coordinate[1]
  return if map[y][x] == 0
  if map[y][x] > 9
    # binding.pry
    map[y][x] = 0
    count_flashed << 1
    adjs = find_adjs(coordinate)
    adjs.each do |adj|
      map[adj[1]][adj[0]] += 1 if map[adj[1]][adj[0]] != 0
      recursive_octupus(map, adj, count_flashed)
    end
  end
end

def new_step(data)
  data = data.map do |line|
    line.map { |p| p += 1 }
  end
  data
end

def sync?(data)
  data.flatten.sum == 0
end

count_flashed = []
counter = 0
loop do
  data = new_step(data)
  data.each_with_index do |line, y|
    line.each_with_index do |point,x|
      recursive_octupus(data, [x, y], count_flashed)
    end
  end
  if sync?(data)
    p counter + 1
    break
  end
  counter += 1
end
# p data
# p count_flashed.sum