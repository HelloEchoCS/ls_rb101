

require 'yaml'
require 'pry'
data = YAML.load_file('day_18_input.yml')

def add(arr1, arr2)
  [arr1, arr2]
end

def explosion_check(level, arr, status, location)
  if arr[0].is_a?(Integer) && arr[1].is_a?(Integer)
    if level > 4
      status[:found] = true
      location.each do |index|
        status[:location] << index
      end
      return
    end
  else
    arr.each_with_index do |element, idx|
      return if status[:found] == true
      if element.is_a?(Array)
        location << idx
        explosion_check(level + 1, element, status, location)
        location.pop
      end
    end
  end
end

def explode(arr, location)
  current_pair = arr
  location[0..-2].each do |index|
    current_pair = current_pair[index]
  end
  left_value = current_pair[location.last][0]
  right_value = current_pair[location.last][1]
  current_pair[location.last] = 0

  target = nil
  location.reverse.each_with_index do |element, idx|
    if element == 1
      target = idx
      break
    end
  end
  if target != nil
    target = location.count - 1 - target
    current_pair = arr
    if target == 0
      if current_pair[0].is_a?(Integer)
        current_pair[0] += left_value
      else
        add_next_right_most_int(current_pair[0], left_value)
      end
    else
      location[0..target].each_with_index do |index, idx|
        current_pair = current_pair[index]
        if idx == target - 1
          if current_pair[0].is_a?(Integer)
            current_pair[0] += left_value
          else
            current_pair = current_pair[0]
            add_next_right_most_int(current_pair, left_value)
          end
        end
      end
    end
  end

  target = nil
  location.reverse.each_with_index do |element, idx|
    if element == 0
      target = idx
      break
    end
  end
  if target != nil
    target = location.count - 1 - target
    current_pair = arr

    if target == 0
      # current_pair = current_pair[1]
      if current_pair[1].is_a?(Integer)
        current_pair[1] += right_value
      else
        add_next_left_most_int(current_pair[1], right_value)
      end
    else
      location[0..target].each_with_index do |index, idx|

        current_pair = current_pair[index]
        if idx == target - 1

          if current_pair[1].is_a?(Integer)
            current_pair[1] += right_value
          else
            current_pair = current_pair[1]
            add_next_left_most_int(current_pair, right_value)
            # loop do
            #   if current_pair[0].is_a?(Integer)
            #     current_pair[0] += right_value
            #     break
            #   else
            #     current_pair = current_pair[0]
            #   end
            # end
          end
        end
      end
    end
  end
end

def add_next_left_most_int(current_pair, value)
  # binding.pry
  loop do
    if current_pair[0].is_a?(Integer)
      current_pair[0] += value
      break
    else
      current_pair = current_pair[0]
    end
  end
end

def add_next_right_most_int(current_pair, value)
  # binding.pry
  loop do
    if current_pair[1].is_a?(Integer)
      current_pair[1] += value
      break
    else
      current_pair = current_pair[1]
    end
  end
end

def split(arr, status)
  arr = arr.map do |element|
    if status[:found]
      element
    else
      if element.is_a?(Integer)
        if element >= 10
          status[:found] = true
          if element.odd?
            [element / 2, element / 2 + 1]
          else
            [element / 2, element / 2]
          end
        else
          element
        end
      else
        split(element, status)
      end
    end
  end
  arr
end

def calculate_mag(arr)
  if arr.is_a?(Integer)
    return arr
  else
    return calculate_mag(arr[0]) * 3 + calculate_mag(arr[1]) * 2
  end
end




n = 0
mags = []
while n < data.count - 1
  counter = n + 1
  while counter < data.count
    p [counter,n]
    snail_num = add(YAML.load_file('day_18_input.yml')[n], YAML.load_file('day_18_input.yml')[counter])
    location = []
    loop do
      status = {found: false, location: []}
      explosion_check(1, snail_num, status, location)
      if status[:found]
        explode(snail_num, status[:location])
        # binding.pry
        next
      end
      snail_num = split(snail_num, status)
      break if status[:found] == false
    end
    mags << calculate_mag(snail_num)
    counter += 1
  end
  n += 1
end

n = 0
counter = 0
while n < data.count - 1
  counter = n + 1
  while counter < data.count
    p [counter,n]
    snail_num = add(YAML.load_file('day_18_input.yml')[counter], YAML.load_file('day_18_input.yml')[n])
    location = []
    loop do
      status = {found: false, location: []}
      explosion_check(1, snail_num, status, location)
      if status[:found]
        explode(snail_num, status[:location])
        # binding.pry
        next
      end
      snail_num = split(snail_num, status)
      break if status[:found] == false
    end
    mags << calculate_mag(snail_num)
    counter += 1
  end
  n += 1
end

p mags.max


# location = []
# test = [[[[4, 0], [5, 4]], [[7, 7], [0, [6, 7]]]], [10, [[11, 9], [11, 0]]]]
# status = {found: false, location: []}
# explosion_check(1, test, status, location)
# explode(test, status[:location])
# p test