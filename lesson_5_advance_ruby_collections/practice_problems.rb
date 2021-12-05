# 1
# arr = ['10', '11', '9', '7', '8']
# arr.map! { |n| n.to_i }
# arr.sort! { |a, b| b <=> a }
# p arr.map! { |n| n.to_s }

# 2
# books = [
#   {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
#   {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
#   {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
#   {title: 'Ulysses', author: 'James Joyce', published: '1922'}
# ]
# p books.sort { |hsh_a, hsh_b| hsh_b[:published] <=> hsh_a[:published] }

# 3
# arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
# p arr1[2][1][3]
# arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
# p arr2[1][:third][0]
# arr3 = [['abc'], ['def'], {third: ['ghi']}]
# p arr3[2][:third][0][0]
# hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
# p hsh1['b'][1]
# hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
# p hsh2[:third].keys[0]

# 4
# arr1 = [1, [2, 3], 4]
# arr1[1][1] = 4
# p arr1

# arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]
# arr2[2] = 4
# p arr2

# hsh1 = {first: [1, 2, [3]]}
# hsh1[:first][2][0] = 4
# p hsh1

# hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}
# hsh2[['a']][:a][2] = 4
# p hsh2

# 5
# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }
# total_age = []
# munsters.each do |key, value_hash|
#   total_age << value_hash["age"] if value_hash["gender"] == "male"
# end
# p total_age.reduce(:+)

# 6
# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }
# munsters.each do |name, details|
#   puts "#{name} is a #{details["age"]}-year-old #{details["gender"]}."
# end

# 7

# 8
# hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}
# vowels = []
# hsh.each_value do |words|
#   words.each do |word|
#     vowels << word.chars.select { |char| "aeiou".include?(char) }
#   end
# end
# p vowels

# 9
# arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]
# arr_new = arr.map do |sub_array|
#   sub_array.sort { |a, b| b <=> a }
# end
# p arr
# p arr_new

# 10
# arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]
# arr_new = arr.map do |hsh|
#   hsh_copy = hsh.dup
#   hsh_copy.each { |k, int| hsh_copy[k] = int + 1 }
#   hsh_copy
# end

# p arr
# p arr_new

# 11
# arr = [[2], [3, 5, 7], [9], [11, 13, 15]]
# arr_new = arr.map do |sub_array|
#   sub_array.select do |int|
#     int % 3 == 0
#   end
# end
# p arr
# p arr_new

# 12
# arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# hsh = {}
# arr.each do |sub_array|
#   hsh[sub_array[0]] = sub_array[1]
# end
# p hsh

# 13
# arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
# arr_new = arr.sort_by do |sub_array|
#   sub_array.select { |int| int.odd? }
# end
# p arr
# p arr_new

# 14
# hsh = {
#   'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
#   'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
#   'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
#   'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
#   'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
# }

# output = []
# hsh.each_value do |details|
#   case details[:type]
#   when 'fruit'
#     output << details[:colors].map { |color| color.capitalize }
#   when 'vegetable'
#     output << details[:size].upcase
#   end
# end
# p output

# 15
# arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]
# arr_new = []

# arr.each do |hsh|
#   arr_new << hsh if hsh.values.flatten.all? { |int| int.even? }
# end
# p arr_new

# 16
# Finally!!

def generate_uuid
  hex_chars = "0123456789abcdef"
  chars = [8, 4, 4, 4, 12]
  output = ""

  chars.each_with_index do |num, index|
    num.times { |n| output << hex_chars[rand(0..15)] }
    break if index == chars.count - 1
    output << "-"
  end
  output
end

p generate_uuid