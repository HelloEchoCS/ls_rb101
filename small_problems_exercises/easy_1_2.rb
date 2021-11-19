=begin
Write a method that takes one integer argument, which may be positive, negative, or zero.
This method returns true if the number's absolute value is odd. You may assume that the argument is a valid integer value.

Problem:
- input: one integer
- output: true if the input's absolute value is odd, false if not.

- questions worth asking:
  - What the "absolute value" means
  - Is zero even or odd?

- requirements
  - the input is only one valid integer, could be negative, zero or positive
  - zero is an even number

Test cases:
puts is_odd?(2)    # => false
puts is_odd?(5)    # => true
puts is_odd?(-17)  # => true
puts is_odd?(-8)   # => false
puts is_odd?(0)    # => false
puts is_odd?(7)    # => true

Data Structure:
- input: an integer
- output: a boolean

Algorithm:
- take one integer argument
- divide the integer by 2 to see if the division == 0
- if the division equals 0 then return false
- otherwise return true

=end

def is_odd?(int)
return false if int.remainder(2) == 0
true
end

puts is_odd?(2)    # => false
puts is_odd?(5)    # => true
puts is_odd?(-17)  # => true
puts is_odd?(-8)   # => false
puts is_odd?(0)    # => false
puts is_odd?(7)    # => true