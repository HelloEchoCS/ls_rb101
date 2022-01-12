require 'pry'

TARGET = 'x=192..251, y=-89..-59'

def get_x_min(int)
  x = 0
  loop do
    break if (x + 1) * (x + 1) + (x + 1) > int
    x += 1
  end
  x
end

# Y_MAX = 9
# Y_MIN = -10
# X_MAX = 30
# X_MIN = get_x_min(40)
# X_BOUNDARY_L = 20
# X_BOUNDARY_R = 30
# Y_BOUNDARY_U = -5
# Y_BOUNDARY_D = -10

Y_MAX = 88
Y_MIN = -89
X_MAX = 251
X_MIN = get_x_min(384)
X_BOUNDARY_L = 192
X_BOUNDARY_R = 251
Y_BOUNDARY_U = -59
Y_BOUNDARY_D = -89




def add_coordinates!(n, v_combs)
  X_MIN.upto(X_MAX) do |x|
    Y_MIN.upto(Y_MAX) do |y|
      coordinate_x = 0
      coordinate_y = 0
      x_copy = x
      y_copy = y
      n.times do
        coordinate_x += x_copy
        coordinate_y += y_copy
        x_copy -= 1 unless x_copy == 0
        y_copy -= 1
      end
      if coordinate_x >= X_BOUNDARY_L && coordinate_x <= X_BOUNDARY_R && coordinate_y >= Y_BOUNDARY_D && coordinate_y <= Y_BOUNDARY_U
        if v_combs[x] == nil
          v_combs[x] = []
          v_combs[x] << y
        else
          v_combs[x] << y
        end
      end
    end
    # binding.pry if x == 30
  end
end

# def add_y!(n, v_combs)
#   v_combs.each_key do |x|
#     Y_MIN.upto(Y_MAX) do |y|
#       coordinate_y = 0
#       y_copy = y
#       n.times do
#         coordinate_y += y_copy
#         y_copy -= 1
#       end
#       v_combs[x] << y if coordinate_y >= Y_BOUNDARY_D && coordinate_y <= Y_BOUNDARY_U
#     end
#   end
# end



possible_v = {}
1.upto(300) do |n|
  add_coordinates!(n, possible_v)
end
pairs = []
possible_v.each do |x, y_arr|
  y_arr.each do |y|
    pairs << [x, y]
  end
end
p pairs.uniq.count