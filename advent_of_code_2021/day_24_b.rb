# require 'pry'

# def find_top_10(serial_number)
#   input = [12,11,13,11,14,-10,11,-9,-3]
#   add_y = [4, 11, 5, 11, 14, 7, 11, 4, 6]
#   while serial_number > 100000000
#     if serial_number.to_s.include?('0')
#       serial_number -= 1
#       next
#     end
#     serial_array = serial_number.to_s.chars.map { |char| char.to_i }
#     z = 0
#     serial_array.each_with_index do |num, index|
#       if input[index] > 0
#         z = z * 26 + num + add_y[index]
#       else
#         if z % 26 != num + (0 - input[index])
#           z = z / 26 * 26 + num + add_y[index]
#         else
#           z = z / 26
#         end
#       end
#     end
#     return [serial_number, z]
#     if z <= 26**3
#       return [serial_number, z]
#     end
#     p serial_number -= 1
#   end

# end

# def find_last_4(temp_z)
#   input = [13,-5,-10,-4,-5]
#   add_y = [5, 9, 12, 14, 14]
#   serial_number = 99999
#   while serial_number > 10000
#     if serial_number.to_s.include?('0')
#       serial_number -= 1
#       next
#     end
#     serial_array = serial_number.to_s.chars.map { |char| char.to_i }
#     z = temp_z
#     serial_array.each_with_index do |num, index|
#       if input[index] > 0
#         z = z * 26 + num + add_y[index]
#       else
#         if z % 26 != num + (0 - input[index])
#           z = z / 26 * 26 + num + add_y[index]
#         else
#           z = z / 26
#         end
#       end
#     end
#     return # serial_number if z == 0
#     serial_number -= 1
#   end
# end

# temp = [999999999, 0]
# loop do
#   p temp = find_top_10(temp[0] - 1)
#   p last_four = find_last_4(temp[1])
#   if last_four
#     p temp
#     p last_four
#     break
#   end
# end

w = [9,9,9,9,9,9,9,9,9,9,9,9,9,9]

def find_max_value(idx_y, idx_x, w)
  add_y = [4, 11, 5, 11, 14, 7, 11, 4, 6, 5, 9, 12, 14, 14]
  add_x = [12, 11, 13, 11, 14, -10, 11, -9, -3, 13,-5,-10,-4,-5]
  a = 1
  b = 1
  while a <= 9
    b = 1
    while b <= 9
      if a + add_y[idx_y] == b + (0 - add_x[idx_x])
        w[idx_y] = a
        w[idx_x] = b
        return [a, b]
      end
      b += 1
    end
    a += 1
  end
end

p find_max_value(0, 13, w)
p find_max_value(1, 12, w)
p find_max_value(2, 11, w)
p find_max_value(3, 8, w)
p find_max_value(4, 5, w)
p find_max_value(6, 7, w)
p find_max_value(9, 10, w)
p w