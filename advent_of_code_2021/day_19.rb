require 'pry'

raw_data = File.read('day_19.txt').split(/\n/)

scanner_data = {}
scanner_no = -1
raw_data.each do |str|
  if str[0..2] == '---'
    scanner_no += 1
    scanner_data[scanner_no] = []
  else
    scanner_data[scanner_no] << str
  end
end
scanner_data.each do |key, value|
  scanner_data[key] = value.map do |coordinate|
    coordinate.split(',').map { |axis| axis.to_i }
  end
end
scanner_data.each do |key, value|
  scanner_data[key] = value.select { |coordinate| coordinate.empty? == false }
end


def get_possible_rotations(coordinate)
  x, y, z = coordinate[0], coordinate[1], coordinate[2]
  possible_rotations = [[x, y, z], [-y, x, z], [x, z, -y], [y, -x, z], [x, -z, y], [x, -y, -z]]
  combo = []
  possible_rotations.each do |co|
    combo += get_combinations(co)
  end
  combo
end

def get_combinations(coordinate)
  x, y, z = coordinate[0], coordinate[1], coordinate[2]
  possible_set = [[x, y, z], [z, y, -x], [-x, y, -z], [-z, y, x]]
end

def rotate(scanner, n)
  scanner.map do |coordinate|
    coordinate = get_possible_rotations(coordinate)[n]
  end
end

def find_diffs(scanner1, scanner2, m, o)
  [scanner1[m][0] - scanner2[o][0], scanner1[m][1] - scanner2[o][1], scanner1[m][2] - scanner2[o][2]]
end

def find_matched(scanner1, scanner2, diff)
  count = 0
  scanner1.count.times do |n|
    scanner2.count.times do |m|
      count += 1 if [scanner1[n][0] - scanner2[m][0], scanner1[n][1] - scanner2[m][1], scanner1[n][2] - scanner2[m][2]] == diff
    end
  end
  count
end

def get_scanner_coordinate(scanner1, scanner2)
  24.times do |n|
    possible = rotate(scanner2, n)
    matched = 0
    scanner1.count.times do |m|
      possible.count.times do |o|
        diff = find_diffs(scanner1, possible, m, o)
        matched = find_matched(scanner1, possible, diff)
        return [diff, n] if matched >= 12
      end
    end
  end
  nil
end

def add_coordinates(c1, c2)
  [c1[0] + c2[0], c1[1] + c2[1], c1[2] + c2[2]]
end

def convert_beacons(scanner, scanner_no, absolute_scanner_coordinates)
  scanner.map do |beacon|
    add_coordinates(beacon, absolute_scanner_coordinates[scanner_no][0])
  end
end

# def initial_absolute(scanner_data)
#   absolute = {}
#   scanner_data.each_key { |key| absolute[key] = [] }
#   absolute
# end



# absolute_scanner_coordinates = {}
# count = 1
# while count < scanner_data.keys.count
#   result = get_scanner_coordinate(scanner_data[0], scanner_data[count])
#   absolute_scanner_coordinates[count] = result if result
#   p count += 1
# end
# beacons = []
# do_not_search = [0]
# loop do
#   temp_scanner_coordinates = {}
#   absolute_scanner_coordinates.each do |scanner, value|
#     next if do_not_search.include?(scanner)
#     current_work_scanner = rotate(scanner_data[scanner], value[1])
#     scanner_data.keys.count.times do |n|
#       next if scanner == n || n == 0 || do_not_search.include?(n)
#       p [scanner, n]
#       result = get_scanner_coordinate(current_work_scanner, scanner_data[n])
#       if result
#         p temp_scanner_coordinates[n] = [add_coordinates(result[0], absolute_scanner_coordinates[scanner][0]), result[1]]
#         do_not_search << scanner unless do_not_search.include?(scanner)
#         p do_not_search
#       end
#     end
#     do_not_search << scanner unless do_not_search.include?(scanner)
#   end
#   temp_scanner_coordinates.each do |key, value|
#     absolute_scanner_coordinates[key] = value
#   end
#   p absolute_scanner_coordinates
#   break if absolute_scanner_coordinates.keys.sum == scanner_data.keys.sum
# end

# absolute_scanner_coordinates[0] = [[0, 0, 0], 0]
# absolute_scanner_coordinates.each do |scanner_no, value|
#   p scanner_no
#   current_work_scanner = rotate(scanner_data[scanner_no], value[1])
#   beacons += convert_beacons(current_work_scanner, scanner_no, absolute_scanner_coordinates)
# end
# p beacons.uniq.count



def manhattan(s1, s2)
  # binding.pry
  result = [s1[0] - s2[0], s1[1] - s2[1], s1[2] - s2[2]]
  result.map! do |num|
    if num < 0
      num = 0 - num
    else
      num
    end
  end
  result.sum
end

# scanners = {1=>[[68, -1246, -43], 2], 3=>[[-92, -2380, -20], 2], 4=>[[-20, -1133, 1061], 19], 2=>[[1105, -1205, 1229], 10]}
scanners = {15=>[[-34, -39, -1212], 5], 19=>[[-23, -18, 1148], 12], 1=>[[1276, -97, -1275], 7], 23=>[[-1232, 18, -1286], 17], 3=>[[-16, 29, 2262], 22], 2=>[[-2296, -97, -1318], 8], 4=>[[-1152, 1250, -1236], 13], 10=>[[-1185, -91, -2525], 21], 9=>[[-2361, 82, -2400], 20], 17=>[[-2424, -1251, -1267], 2], 20=>[[-2341, 1264, -1211], 4], 5=>[[-2394, 32, -3766], 18], 18=>[[-2426, 1264, -2514], 15], 7=>[[-3490, -1240, -1188], 6], 21=>[[-2307, -2338, -1261], 23], 25=>[[-2306, -1164, 24], 13], 11=>[[-2457, -48, -4796], 9], 12=>[[-2413, -1237, -3623], 1], 13=>[[-2354, 1125, -3678], 19], 22=>[[-3623, 9, -3737], 10], 24=>[[-3477, 1147, -2567], 17], 16=>[[-2316, -2427, 3], 3], 6=>[[-1164, -1250, 15], 14], 8=>[[-3651, -2454, 15], 16], 14=>[[-3533, -3667, -159], 11]}
# keys = scanners.keys
keys = scanners.keys
sums = []
keys.count.times do |n|
  m = n + 1
  while m < keys.count
    sums << manhattan(scanners[keys[n]][0], scanners[keys[m]][0])
    m += 1
  end
end
p sums.max
