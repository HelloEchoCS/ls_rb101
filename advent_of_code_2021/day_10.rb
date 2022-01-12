require 'yaml'
require 'pry'

VALUES = { '(' => -3,
           '[' => -57,
           '{' => -1197,
           '<' => -25137,
           ')' => 3,
           ']' => 57,
           '}' => 1197,
           '>' => 25137
}

POINTS = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }

PAIRS = { ')' => '(', ']' => '[', '}' => '{', '>' => '<' }
data = File.read('day_10.txt').split(/\n/)
raw_data = data.map { |str| str.chars }

=begin
A
- iterate through each line, for each symbol with index:
  - if it is [']', ')', '}', '>'], value_sum = value(symbol)
  - iterate through line[0..index].reverse, for each sym
    - value_sum += value(sym)
    - if sym == PAIRS[symbol]
     - if value_sum == 0, break
     - else next
  - if after all the iterations, value_sum != 0, return symbol



=end

def find_pairs(line, current_sym, index)
  next_sym = line[index + 1]
  # binding.pry
  return index + 1 if next_sym == PAIRS[current_sym]
  return 10000 if PAIRS.values.include?(next_sym)
  find_pairs(line, current_sym, find_pairs(line, next_sym, index + 1))
end

def find_corruption_score(line)
  line.each_with_index do |symbol, index|
    if PAIRS.keys.include?(symbol)
      reverse_line = line[0..index].reverse
      return VALUES[symbol] if find_pairs(reverse_line, symbol, 0) == 10000
    end
  end
  0
end

sum = 0
raw_data.each do |line|
  find_corruption_score(line)
  sum += find_corruption_score(line)
end
p sum

=begin
def find_corruption_score(line)
  line.each_with_index do |symbol, index|
    if PAIRS.keys.include?(symbol)
      next if PAIRS[symbol] == line[index - 1]
      return VALUES[symbol] if PAIRS.values.include?(line[index - 1])
      value_sum = 0
      reverse_line = line[0..(index - 1)].reverse
      reverse_line.each_with_index do |sym, idx|
        value_sum += VALUES[sym]
        # p [sym, value_sum, index]
        if value_sum == 0
          break if reverse_line[idx + 1] == PAIRS[symbol]
          return VALUES[symbol] if PAIRS.values.include?(reverse_line[idx + 1])
          next if PAIRS.keys.include?(reverse_line[idx + 1])
        end
        # binding.pry if index > 90
      end
      return VALUES[symbol] if value_sum =! 0
      # binding.pry if index > 90
    end
  end
  0
end





scores = []
raw_data.each_with_index do |line, idx|
  next if find_corruption_score(line) != 0
  add_symbols = []
  loop do
    line_copy = []
    PAIRS.each_key do |key|
      line_copy = line
      line_copy += [key]
      if find_corruption_score(line_copy) == 0
        add_symbols << key
        line << key
        # break
      end
      # binding.pry
    end
    if all_paired?(line)
      p add_symbols
      scores << calculate_score(add_symbols)
      break
    end
    binding.pry
  end
end

=end

def calculate_score(arr)
  score = 0
  arr.each do |sym|
    score = score * 5 + POINTS[sym]
  end
  score
end

def all_paired?(arr)
  sum = 0
  arr.each { |sym| sum += VALUES[sym] }
  sum == 0
end

scores = []
raw_data.each_with_index do |line, idx|
  next if find_corruption_score(line) != 0
  add_symbols = []
  loop do
    line_copy = []
    PAIRS.each_key do |key|
      line_copy = line
      line_copy += [key]
      if find_corruption_score(line_copy) == 0
        add_symbols << key
      end
    end
    line << add_symbols.last
    if all_paired?(line)
      p add_symbols
      scores << calculate_score(add_symbols)
      break
    end
    # binding.pry
  end
end
p scores
p scores.sort[(scores.length - 1) / 2]




=begin
What I learnt from this problem:
- Test cases won't always cover all the edge cases you might encounter when using real data
 -
- When mutating




=end
