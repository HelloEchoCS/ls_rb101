=begin
Write a method that takes one argument, a positive integer, and returns the sum of its digits.

=end

def sum(int)
  sum = 0
  int.to_s.chars.each { |element| sum += element.to_i if element.to_i.to_s == element }
  sum
end


puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45