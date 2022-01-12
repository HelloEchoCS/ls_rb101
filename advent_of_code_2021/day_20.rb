# require 'pry'

=begin
A
- transform original image to 0 and 1s
- initialize a new image, increase the scope of the image by 2
- get x_max and y_max
- insert the original image from 2 to (x_max - 2) each row, starting from row 2 until row (y_max - 2)
- initialize a new `image` []
- work from 1 to (x_max - 1) each row, starting from row 1 until row (y max - 1)
  - for each dot, look for its surronding dots, get the binary number (string)
  - get the decimal number
  - lookup the decimal on the algorithm string
  - apply and add the current dot to `image` according to the algorithm string

=end

algorithm = File.read('day_20_algor.txt').chars

algorithm = algorithm.map do |char|
  if char == '.'
    0
  else
    1
  end
end

image = File.read('day_20_image.txt').split(/\n/).map { |str| str.chars }



def transform_image!(image)
  image.count.times do |y|
    image[0].count.times do |x|
      image[y][x] = 0 if image[y][x] == '.'
      image[y][x] = 1 if image[y][x] == '#'
    end
  end
end

def create_bigger_image(image, step)
  expanded_image = []
  0.upto(image.count + 3) do |y|
    line = []
    0.upto(image[0].count + 3) do |x|
      line[x] = 0 if step.even?
      line[x] = 1 if step.odd?
    end
    expanded_image << line
  end
  expanded_image
end

def insert_original_image!(image, expanded_image)
  y_max = expanded_image.count - 1
  x_max = expanded_image[0].count - 1
  2.upto(y_max - 2) do |y|
    y_o = y - 2
    2.upto(x_max - 2) do |x|
      x_o = x - 2
      expanded_image[y][x] = image[y_o][x_o]
    end
  end
end

def locate_nine_dots(y, x)
  [[y - 1, x - 1], [y - 1, x], [y - 1, x + 1], [y, x - 1], [y, x], [y, x + 1], [y + 1, x - 1], [y + 1, x], [y + 1, x + 1]]
end

def parse_decimal(arr, expanded_image)
  binary_arr = arr.map { |coordinate| expanded_image[coordinate[0]][coordinate[1]].to_s }
  binary_arr.join.to_i(2)
end

def draw_new_image(y_max, x_max, expanded_image, algorithm)
  new_image = []
  1.upto(y_max - 1) do |y|
    line = []
    y_new = y - 1
    1.upto(x_max - 1) do |x|
      x_new = x - 1
      nine_dots = locate_nine_dots(y, x)
      decimal = parse_decimal(nine_dots, expanded_image)
      line[x_new] = algorithm[decimal]
    end
    new_image << line
  end
  new_image
end

# def calculate_light_dots(image)
#   # sum = 0
#   # 1.upto(image.count - 2) do |y|
#   #   1.upto(image[0].count - 2) do |x|
#   #     sum += image[y][x]
#   #   end
#   # end
#   # sum
#   image.flatten.sum
# end

def shrink_image(image)
  new_image = []
  p image.count
  p image[0].count
  1.upto(image.count - 2) do |y|
    line = []
    1.upto(image[0].count - 2) do |x|
      line[x - 1] = image[y][x]
    end
    new_image << line
  end
  p new_image.count
  p new_image[0].count
  new_image

end

transform_image!(image)

50.times do |step|
  expanded_image = create_bigger_image(image, step)
  insert_original_image!(image, expanded_image)

  y_max = expanded_image.count - 1
  x_max = expanded_image[0].count - 1

  image = draw_new_image(y_max, x_max, expanded_image, algorithm)
  # image = shrink_image(image)
end
p image.flatten.sum


