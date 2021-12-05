require 'yaml'

input_oxygen = YAML.load_file('day_3.yml').split(" ")
input_co2 = YAML.load_file('day_3.yml').split(" ")

def power_consumption(arr)
  count = arr[0].length
  gamma = ""
  epsilon = ""
  count.times do |n|
    count0 = 0
    count1 = 0
    arr.each do |num|
      count0 += 1 if num[n] == '0'
      count1 += 1 if num[n] == '1'
    end
    if count0 > count1
      gamma += '0'
      epsilon += '1'
    else
      gamma += '1'
      epsilon += '0'
    end
  end
  gamma.to_i(2) * epsilon.to_i(2)
end

def oxygen_rating(arr)
  length = arr[0].length
  length.times do |n|
    break if arr.length == 1
    count0 = 0
    count1 = 0
    arr.each do |num|
      count0 += 1 if num[n] == '0'
      count1 += 1 if num[n] == '1'
    end
    if count0 > count1
      arr.select! do |num|
        num[n] == '0'
      end
    else
      arr.select! do |num|
        num[n] == '1'
      end
    end
  end
  arr[0].to_i(2)
end

def co2_rating(arr)
  length = arr[0].length
  length.times do |n|
    break if arr.length == 1
    count0 = 0
    count1 = 0
    arr.each do |num|
      count0 += 1 if num[n] == '0'
      count1 += 1 if num[n] == '1'
    end
    if count0 <= count1
      arr.select! do |num|
        num[n] == '0'
      end
    else
      arr.select! do |num|
        num[n] == '1'
      end
    end
  end
  arr[0].to_i(2)
end

p oxygen_rating(input_oxygen) * co2_rating(input_co2)