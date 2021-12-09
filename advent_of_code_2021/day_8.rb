require 'yaml'
require 'pry'

=begin

 1111
2    3
2    3
 4444
5    6
5    6
 7777

=end

UNIQUE_NUMS = { 1 => 2, 4 => 4, 7 => 3, 8 => 7 }
NUM_PATTERNS = { 0 => '123567', 1 => '36', 2 => '13457', 3 => '13467', 4 => '2346', 5 => '12467', 6 => '124567', 7 => '136', 8 => '1234567', 9 => '123467'}

raw_data = YAML.load_file('day_8.yml').split(" ")

counter = 0
entries = []
while counter < raw_data.length / 15
  entry = []
  15.times do |n|
    entry << raw_data[15 * counter + n]
  end
  entries << entry
  counter += 1
end
p entries
=begin
A
- define unique numbers hash
- iterate through entries, for each entry
  - iterate through the last four values, for each value
    - get the size of the string and find the match in the hash values
    - if matches, counter += 1
- output counter

=end

# def find_uniq_nums(arr)
#   count = 0
#   arr.each do |entry|
#     entry[-4..-1].each do |num_str|
#       count += 1 if UNIQUE_NUMS.values.include?(num_str.length)
#     end
#   end
#   count
# end

# p find_uniq_nums(entries)

=begin
CONSTANT: pattern of each number
A:
- iterate through all entries
  - intitialize everything
  - iterate through first 10 strs in a entry
    - find all unique strs, calculate number 1
    - calculate pattern for '36'
    - calculate pattern for '24'
    - calculate pattern for '57'
    - pattern for '13657'
    - pattern for '12457'
    - pattern for '12436'
  - find all 3 patterns which has 6 chars
  - iterate 3 patterns, for each pattern
    - if pattern.include?(pattern for '13657'), 2 => the uniq char
    - if pattern.include?(pattern for '12457'), 6 => the uniq char
    - if pattern.include?(pattern for '12436'), 7 => the uniq char
  - 3 => pattern for '36' - char for '6'
  - 4 => pattern for '24' - char for '2'
  - 5 => pattern for '57' - char for '7'

  - iterate through last 4 str in a entry
    - get digit map for each str, compare to the CONSTANT, output the real number

  combine 4 digits to an int
  add the int to `sum`
- end

output sum
=end
def intitialize_patterns
 { p1: [], p136: [], p36: [], p2346: [], p1234567: [], p24: [], p57: [], p13567: [], p12457: [], p12346: []}
end

def intitialize_digit_map
  { '1' => [], '2' => [], '3' => [], '4' => [], '5' => [], '6' => [], '7' => [] }
end

def find_1!(arr_of_strs, hsh, pattern_known)
  arr_of_strs.each do |str|
    pattern_known[:p136] = str.chars if str.length == 3
    pattern_known[:p36] = str.chars if str.length == 2
    pattern_known[:p2346] = str.chars if str.length == 4
    pattern_known[:p1234567] = str.chars if str.length == 7
  end
  pattern_known[:p1] = pattern_known[:p136] - pattern_known[:p36]
  hsh['1'] = pattern_known[:p1]
end

def find_key_patterns!(pattern_known, hsh)
  pattern_known[:p24] = pattern_known[:p2346] - pattern_known[:p36]
  pattern_known[:p57] = pattern_known[:p1234567] - pattern_known[:p2346] - pattern_known[:p1]
  pattern_known[:p13567] = pattern_known[:p1] + pattern_known[:p36] + pattern_known[:p57]
  pattern_known[:p12457] = pattern_known[:p1] + pattern_known[:p24] + pattern_known[:p57]
  pattern_known[:p12346] = pattern_known[:p1] + pattern_known[:p24] + pattern_known[:p36]
end

def find_6_length(arr_of_strs)
  arr_of_strs.select do |str|
    str.length == 6
  end
end

def mapping!(arr_of_strs, pattern_known, hsh)
  arr_of_strs.each do |str|
    if (str.chars + pattern_known[:p13567]).uniq.count == 6
      hsh['2'] = str.chars - pattern_known[:p13567]
    elsif (str.chars + pattern_known[:p12457]).uniq.count == 6
      hsh['6'] = str.chars - pattern_known[:p12457]
    elsif (str.chars + pattern_known[:p12346]).uniq.count == 6
      hsh['7'] = str.chars - pattern_known[:p12346]
    end
  end
end

def mapping_rest!(pattern_known, hsh)
  hsh['3'] = pattern_known[:p36] - hsh['6']
  hsh['4'] = pattern_known[:p24] - hsh['2']
  hsh['5'] = pattern_known[:p57] - hsh['7']
end

def decode(arr_of_strs, digit_map)
  numbers = []
  arr_of_strs.each do |str|
    digit_map_key = []
    str.chars.each do |char|
      digit_map_key << digit_map.key([char])
    end
    numbers << NUM_PATTERNS.key(digit_map_key.sort.join)
  end
  numbers.join.to_i
end

sum = 0
entries.each do |entry|
  number = 0
  p patterns = intitialize_patterns
  p digit_map = intitialize_digit_map
  find_1!(entry, digit_map, patterns)
  find_key_patterns!(patterns, digit_map)
  p six_length = find_6_length(entry)
  mapping!(six_length, patterns, digit_map)
  mapping_rest!(patterns, digit_map)
  p number = decode(entry[-4..-1], digit_map)
  sum += number
end
