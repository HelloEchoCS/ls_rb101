require 'yaml'
require 'pry'

raw_data = YAML.load_file('day_14.yml').split.select { |str| str != '->' }
insertion_rules = {}
(raw_data.count / 2).times do |n|
  insertion_rules[raw_data[n * 2]] = raw_data[n * 2 + 1]
end

template = 'CHBBKPHCPHPOKNSNCOVB'

=begin
P
- given a starting polymer template and insertions rules, after 10 steps,
take the quantity of the most common element and subtract the quantity of the least common element.
- rules
  - insert only happens in immediately adjacent elements
  - pairs that about to be inserted overlap, the second element of a pair will be the first element of the next pair.
  - inserted elements are not part of a pair until the next step

D
- input: hash, string
- output: string, num

A
- iterate 10 times
  - create a copy of current polymer_str: `polymer_arr`
  - iterate through each pair: polymer_arr[x][x + 1]
    - find the value of key `pair` in `insertion_rules`
    - add the value to `chars`
  - insert the chars to polymer_str


- iterate through polymer_str.chars.uniq, for each char
  - counts << polymer_str.chars.count(char)

- counts.max - counts.min

=end

def initialize_counter(insertion_rules)
  hsh = {}
  (insertion_rules.keys.join + insertion_rules.values.join).chars.uniq.each do |key|
    hsh[key] = 0
  end
  hsh
end

def initialize_pairs_count(insertion_rules, template)
  hsh = {}
  insertion_rules.each_key { |key| hsh[key] = 0 }
  (template.length - 1).times do |n|
    hsh[template[n] + template[n + 1]] += 1
  end
  hsh
end

def initialize_added_pairs(insertion_rules)
  hsh = {}
  insertion_rules.each_key { |key| hsh[key] = 0 }
  hsh
end

def each_step(pairs_count, insertion_rules)
  added_pairs_count = initialize_added_pairs(insertion_rules)
  pairs_count.each do |pair, count|
    next if count == 0
    new_pair_left = pair[0] + insertion_rules[pair]
    new_pair_right = insertion_rules[pair] + pair[1]
    added_pairs_count[new_pair_left] += count
    added_pairs_count[new_pair_right] += count
    pairs_count[pair] = 0
    # binding.pry
  end
  added_pairs_count.each do |pair, count|
    pairs_count[pair] += count
  end
end

def calculate_element(pairs_count, counter, insertion_rules, template)
  pairs_count.each do |pair, count|
    counter[pair[1]] += count
  end
  counter[template[0]] += 1
  counter
end

counter = initialize_counter(insertion_rules)
pairs_count = initialize_pairs_count(insertion_rules, template)
40.times do
  each_step(pairs_count, insertion_rules)
  pairs_count.values.sum
end
counter =  calculate_element(pairs_count, counter, insertion_rules,template)
p counter.values.max - counter.values.min




# def insert_c(str, chars)
#   result = []
#   str.length.times do |n|
#     result[n * 2] = str[n]
#   end
#   chars.length.times do |m|
#     result[m * 2 + 1] = chars[m]
#   end
#   result
# end

# count_hsh = initialize_count(insertion_rules)

# polymer_str = 'NN'
# 8.times do
#   insert_chars = []
#   (polymer_str.length - 1).times do |n|
#     insert_char = insertion_rules[polymer_str[n] + polymer_str[n + 1]]
#     insert_chars << insert_char
#     count_hsh[insert_char] += 1
#   end
#   p polymer_str = insert_c(polymer_str, insert_chars).join
#   count_hsh

# end

# counts = []
# polymer_str.chars.uniq.each do |char|
#   counts << polymer_str.chars.count(char)
# end
# counts.max - counts.min


# def count_chars(depth, first_pair, pair, count_hsh, insertion_rules)
#   insert_char = insertion_rules[pair]
#   count_hsh[insert_char] += 1
#   next_left_pair = pair[0] + insert_char
#   binding.pry
#   if next_left_pair == first_pair
#     p depth + 1
#     return
#   end
#   count_chars(depth + 1, first_pair, next_left_pair, count_hsh, insertion_rules)
#   # count_chars(depth - 1, next_right_pair, count_hsh, insertion_rules)
# end

# # def count_chars(depth, pair, count_hsh, insertion_rules)
# #   if depth == 0
# #     return count_hsh
# #   else
# #     insert_char = insertion_rules[pair]
# #     next_left_pair = pair[0] + insert_char
# #     next_right_pair = insert_char + pair[1]
# #     count_chars(depth - 1, next_left_pair, add_count(next_left_pair, count_hsh, insertion_rules), insertion_rules)
# #     # count_chars(depth - 1, next_right_pair, add_count(next_right_pair, count_hsh, insertion_rules), insertion_rules)
# #   end
# # end

# def add_count(pair, count_hsh, insertion_rules)
#   insert_char = insertion_rules[pair]
#   count_hsh[insert_char] += 1
#   count_hsh
# end



# # polymer_str = template
# count_hsh = initialize_count(insertion_rules)
# # (polymer_str.length - 1).times do |n|
# #   pair = polymer_str[n] + polymer_str[n + 1]
# #   count_chars(0, pair, count_hsh, insertion_rules)
# #   p count_hsh
# # end

# insertion_rules.each_key do |key|
#   count_chars(0, key, key, count_hsh, insertion_rules)
# end
