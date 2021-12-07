require 'yaml'
require 'pry'

raw_data = YAML.load_file('day_5.yml')
data_removed_arrows = raw_data.split(" ").select { |str| str != "->" }
data_arrays = []
data_removed_arrows.each do |str|
  data_arrays << str.split(",")
end
parsed_data = []
(data_arrays.count / 2).times do |n|
  parsed_data << [data_arrays[n * 2]] + [data_arrays[n * 2 + 1]]
end

parsed_data.map! do |line|
  line.map do |coordinate|
    coordinate.map do |n|
      n.to_i
    end
  end
end


=begin
P
input: coordinates for start points and end points of lines
output: number of points that at least two lines overlap


D
input:

A
- pick horizontal and vertical lines
  - iterate through each line
    - if x1 == x2 or y1 == y2, put this line into a new array
- create a point diagram(array)
  - each line is an array, number of elements = biggest x in the new array, value = 0
  - number of lines = biggest y in the new array
- mark points
  - iterate through lines
    - determine points each line go through
    - mark points on the diagram
- calculate how many points has at least 2 lines overlap
  - iterate through the diagram
  - find out how many elements has a value >= 2


=end

def hor_ver_collection(arr)
  arr.select do |line|
    line[0][0] == line[1][0] || line[0][1] == line[1][1]
  end
end

def initialize_diagram
  diagram = []
  1000.times do |y|
    line = []
    1000.times do |x|
      line << 0
    end
    diagram << line
  end
  diagram
end

def mark_points(lines, diagram)
  lines.each do |line|
    points = determine_points(line)
    points.each do |point|
      diagram[point[0]][point[1]] += 1
    end
  end
  diagram
end

def determine_points(line)
  points = []
  x1 = line[0][0]
  y1 = line[0][1]
  x2 = line[1][0]
  y2 = line[1][1]
  if x1 == x2
    max = [y1, y2].max
    min = [y1, y2].min
    while min <= max
      points << [x1, min]
      min += 1
    end
  elsif y1 == y2
    max = [x1, x2].max
    min = [x1, x2].min
    while min <= max
      points << [min, y1]
      min += 1
    end
  else
    min_x = [x1, x2].min
    min_y = [y1, y2].min
    max_x = [x1, x2].max
    max_y = [y1, y2].max
    if x1 > x2 && y1 > y2
      while min_x <= max_x
        points << [min_x, min_y]
        min_x += 1
        min_y += 1
      end
    elsif x1 < x2 && y1 < y2
      while min_x <= max_x
        points << [min_x, min_y]
        min_x += 1
        min_y += 1
      end
    elsif x1 > x2 && y1 < y2
      while min_x <= max_x
        points << [min_x, max_y]
        min_x += 1
        max_y -= 1
      end
    else
      while min_x <= max_x
        points << [min_x, max_y]
        min_x += 1
        max_y -= 1
      end
    end
  end
  points
end

def calculate_overlap(diagram)
  count = 0
  diagram.flatten.each do |point|
    count += 1 if point >1
  end
  count
end

diagram = initialize_diagram
mark_points(parsed_data, diagram)
p calculate_overlap(diagram)
