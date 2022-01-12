=begin
P
- move seacucumbers until none of them can move, ouput steps taken
- rules
  - every step, east facing sea cucumbers(sc) move first, south second
  - each sc only moves if it doesn't have another in front of it, otherwise stay until the next step
  - sc that moves off the edge appear on the oppsite side of the map

D
- input: nested array
- output: int

A
- initialize `step` to 0
- loop until `moved` is false
  1. move east facing sc
    - iterate through all lines, for each line:
      - iterate through all scs, for each sc:
        - if it's east facing
          - see if its right position is empty (or oppsite position is empty if on boarder)
          - if yes, then move to that position, set current position as empty, set `moved` as true
  2. move south facing sc
  - iterate through all lines, for each line:
      - iterate through all scs, for each sc:
        - if it's south facing
          - see if its downward adjacent position is empty (or oppsite position is empty if on boarder)
          - if yes, then move to that position, set current position as empty
  - step += 1

=end

map = File.read('day_25.txt').split(/\n/).map { |line| line.chars }
map_temp = File.read('day_25.txt').split(/\n/).map { |line| line.chars }
X_MAX = map[0].length - 1
Y_MAX = map.length - 1

def initialize_map_temp(map)
  map_temp = []
  map.each_with_index do |l, idx_y|
    line = []
    l.each_with_index do |sc, idx_x|
      line << '.' if sc == '.'
      line << '>' if sc == '>'
      line << 'v' if sc == 'v'
    end
    map_temp << line
  end
  map_temp
end

def copy_map!(map, map_temp)
  map_temp.each_with_index do |line, idx_y|
    line.each_with_index do |sc, idx_x|
      map[idx_y][idx_x] = sc
    end
  end
end

def step_east!(map, map_temp, status)
  map.each_with_index do |line, idx_y|
    line.each_with_index do |sc, idx_x|
      if sc == '>'
        if east_location_empty?(map, idx_y, idx_x)
          move_east!(map_temp, idx_y, idx_x)
          status[:moved] = true
        end
      end
    end
  end
end

def step_south!(map, map_temp, status)
  map.each_with_index do |line, idx_y|
    line.each_with_index do |sc, idx_x|
      if sc == 'v'
        if south_location_empty?(map, idx_y, idx_x)
          move_south!(map_temp, idx_y, idx_x)
          status[:moved] = true
        end
      end
    end
  end
end

def east_location_empty?(map, y, x)
  if x == X_MAX   # if on the eastern boarder
    return true if map[y][0] == '.'
  else
    return true if map[y][x + 1] == '.'
  end
  false
end

def south_location_empty?(map, y, x)
  if y == Y_MAX   # if on the southern boarder
    return true if map[0][x] == '.'
  else
    return true if map[y + 1][x] == '.'
  end
  false
end

def move_east!(map, y, x)
  if x == X_MAX   # if on the eastern boarder
    map[y][0] = '>'
  else
    map[y][x + 1] = '>'
  end
  map[y][x] = '.'
end

def move_south!(map, y, x)
  if y == Y_MAX   # if on the southern boarder
    map[0][x] = 'v'
  else
    map[y + 1][x] = 'v'
  end
  map[y][x] = '.'
end

status = { moved: false }
step = 0
status[:moved] = true
while status[:moved] == true
  status[:moved] = false
  step_east!(map, map_temp, status)
  copy_map!(map, map_temp)
  # p map
  map_temp = initialize_map_temp(map)
  step_south!(map, map_temp, status)
  copy_map!(map, map_temp)
  # p map
  p step += 1
end

p step