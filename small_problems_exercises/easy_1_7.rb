=begin
Write a method that takes one argument, a positive integer, and returns a string of alternating 1s and 0s, always starting with 1.
The length of the string should match the given integer.



=end
require 'pry'

def stringy(int, start_num=1)
  return ('10' * (int / 2)) + ('1' * (int % 2)) if start_num == 1
  return ('01' * (int / 2)) + ('0' * (int % 2)) if start_num == 0
end

puts stringy(6)
puts stringy(9, 0)
puts stringy(4)
puts stringy(7, 0)
