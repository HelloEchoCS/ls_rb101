=begin
A
- initialize `state` to off everything
- iterate through raw_data, for each step, extract the `cube`
  - iterate through `cube list`, find `overlaps` between `current cube` and `list cube`
  - if action is 'on'
    - if overlap exists
      - calculate_overlap(overlaps, on)
    - if overlap doesn't exist
      - add current cube's number to sum
  - if action is 'off'
    - if overlap exists
      - calculate_overlap(overlaps, off)
    - if overlap doesn't exist
      - next iteration

- find overlaps
  - a0 < b0/b1 < a1 or b0 < a0/a1 < b1

- calculate_overlap (overlaps)
  - if overlaps has only one element
    return the cube's number
  - if overlap exists
    - if action is 'on'
      -　


=end


def parse_xyz(str)
  hsh = {}
  arr = str.split(",")
  arr = arr.map { |axis| axis.split("=") }
  arr.each { |axis| hsh[axis[0].to_sym] = axis[1].split("..").map { |num| num.to_i } }
  hsh
end

def find_overlaps(cube1, cube2)
  x11, x12, y11, y12, z11, z12 = cube1[:x][0], cube1[:x][1], cube1[:y][0], cube1[:y][1], cube1[:z][0], cube1[:z][1]
  x21, x22, y21, y22, z21, z22 = cube2[:x][0], cube2[:x][1], cube2[:y][0], cube2[:y][1], cube2[:z][0], cube2[:z][1]
  if x11 > x22 || x12 < x21 || y11 > y22 || y12 < y21 || z11 > z22 || z12 < z21
    return nil
  else
    x = [x11, x12, x21, x22].sort.values_at(1, 2)
    y = [y11, y12, y21, y22].sort.values_at(1, 2)
    z = [z11, z12, z21, z22].sort.values_at(1, 2)
    return { x: x, y: y, z: z }
  end
end

def calculate_cubes(cube)
  (cube[:x][1] - cube[:x][0] + 1) * (cube[:y][1] - cube[:y][0] + 1) * (cube[:z][1] - cube[:z][0] + 1)
end

def calculate_on(overlaps, action, cube_list)
  if overlaps.count == 1
    return calculate_cubes(overlaps[0])
  else
    if action == 'off'
  end
end

def calculate_off(overlaps, cube_list)
  if overlaps.count == 1
    return calculate_cubes(overlaps[0])
  else

  end
end

raw_data = File.read("day_22.txt").split(/\n/).map { |step| step.split(" ") }
raw_data.each { |step| step[1] = parse_xyz(step[1]) }
p raw_data