=begin
DS
input: array
output: array

A:
- copy the original array as arr_copy
- remove the first element of arr_copy then appened it to arr_copy
- output arr_copy

=end

def rotate_array(arr)
  arr_copy = copy_array(arr)
  removed_element = arr_copy.shift
  arr_copy << removed_element
  arr_copy
end

def copy_array(arr)
  arr_copy = []
  arr.each_with_index do |_, index|
    arr_copy[index] = arr[index]
  end
  arr_copy
end


=begin
A:
- convert int to str
- get the last n chars of the str based on argument n => to_be_rotated
- use rotate_array to rotate to_be_rotated
- reassign last n chars of the str
- convert str back to int

=end

def rotate_rightmost_digits(str, n)
  # str = int.to_s
  last_digits = str[-n..-1].chars
  rotated = rotate_array(last_digits)
  str[-n..-1] = rotated.join
  str
  # str.to_i
end


# p rotate_rightmost_digits(735291, 1) == 735291
# p rotate_rightmost_digits(735291, 2) == 735219
# p rotate_rightmost_digits(735291, 3) == 735912
# p rotate_rightmost_digits(735291, 4) == 732915
# p rotate_rightmost_digits(735291, 5) == 752913
# p rotate_rightmost_digits(735291, 6) == 352917

=begin
P:
input: integer
output: integer
rules:
  - rotate first digit, then lock first digit
  - rotate first 2 digits, then lock first 2 digits
  ... until last 2 digits rotated

be careful:
302581 => 025813
better be dealing with strings until the very end!

DS:
array with strings

A:
- get length of the input int `n`
- convert the int to str
- while n > 1
    rotate n rightmost digits
    n -= 1
- get the final result and convert it back to int
- return the int

=end


def max_rotation(int)
  str = int.to_s
  n = str.length
  while n > 1
    str = rotate_rightmost_digits(str, n)
    n -= 1
  end
  str.to_i
end

# p max_rotation(735291) == 321579
# p max_rotation(3) == 3
# p max_rotation(35) == 53
# p max_rotation(105) == 15 # the leading zero gets dropped
# p max_rotation(8_703_529_146) == 7_321_609_845
p max_rotation(800020) == 82
p max_rotation(100000000001) == 1000010