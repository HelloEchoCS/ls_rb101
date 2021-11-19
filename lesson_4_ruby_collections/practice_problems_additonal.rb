# # 1
# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# def hash_transform(array)
#   array.each_with_object({}) do |name, hash|
#     hash[name] = array.index(name) + 1
#   end
# end

# p hash_transform(flintstones)

# 2
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# def addup_ages(hsh)
#   hsh.values.reduce(:+)
# end

# p addup_ages(ages)

# #3
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# def remove_over_100(ages)
#   ages.each { |key, value| ages.delete(key) if value >= 100 }
# end

# remove_over_100(ages)
# p ages

# 4
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# def minimum(ages)
#   ages.values.sort.first
# end

# p minimum(ages)

# # 5
# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# def start_with_be(names)
#   index = 0
#   loop do
#     break if index == names.count
#     break if names[index][0..1] == "Be"
#     index += 1
#   end
#   index
# end

# p start_with_be(flintstones)

# 6
# flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# flintstones.map! { |name| name[0, 3] }
# p flintstones

# 7
# statement = "The Flintstones Rock"

# def count_chars(string)
#   char_count = {}
#   string.chars.uniq.each { |char| char_count[char] = string.count(char) }
#   char_count.delete(" ")
#   char_count
# end

# p count_chars(statement)

# 8
# => 1, 3
# => 1, 2

# 9
# words = "the flintstones rock"

# def titleize(string)
#   capitalized_words = string.split(" ").map { |word| word.capitalize }
#   capitalized_words.join(" ")
# end

# p titleize(words)

# 10
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def get_age_group(age)
  return "kid" if age <= 17
  return "senior" if age >= 65
  "adult"
end

munsters.each do |_, value|
  value["age_group"] = get_age_group(value["age"])
end

p munsters

a = [1, 2, 3]
a.each do |x|
  break
  puts x
end

# => nil