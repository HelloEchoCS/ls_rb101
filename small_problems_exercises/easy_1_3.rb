=begin
Write a method that takes one argument, a positive integer, and returns a list of the digits in the number.

Problem:
- return all the digits of a given positive integer
- input: a positive integer
- output: an array with all the digits of the given integer
- requirements:
  - all the digits are in order
  - same number counts as different digits

Data Structure:
- input: integer
- output: an array, each element is an integer

Algorithm:
- take a positive integer as one argument
- convert the integer to a string, then split the string into an array which contains all the digits in the string form
- for each element in the array, convert the element back to an integer
- return the array


=end

def digit_list(int)
  int.to_s.split("").map(&:to_i)
end

puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true