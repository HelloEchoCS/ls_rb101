vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'suv', 'truck',
  'motorcycle', 'motorcycle', 'car', 'truck'
]

=begin
Write a method that counts the number of occurrences of each element in a given array.

Problem:
- input: a given array
- output: the number of occurrences of each element in the array
- requirements:
  - count the occurrences of each unique element
  - the judgement of uniqueness is case-sensitive, meaning 'a' != 'A'

Data Structure
- input: an array
- output: print each element with the number of occurence alongside it

Algorithm:
- take an array as an argument
- create an empty hash called 'occurrence'
- for each element in the array:
  - find the key in the hash with the value of the element, then increment the value by 1
  - if the key is not found, create a new key-value pair, with the name of the key as the element, and set the value = 1
- For each key-value pair in the hash, print in a new line, with the format "key => value"

=end

def count_occurrences(vehicles)
  occurence = {}
  vehicles.each(&:downcase!)
  vehicles.each { |element| occurence[element] = vehicles.count(element) }
  occurence.each { |key, value| puts "#{key} => #{value}" }
end

count_occurrences(vehicles)