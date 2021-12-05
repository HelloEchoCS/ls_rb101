require 'yaml'

def calculate_position(arr)
  horizontal = 0
  depth = 0
  aim = 0
  arr.each do |command|
    if command.include?('forward')
      horizontal += command[-1].to_i
      depth += aim * command[-1].to_i
    end
    aim += command[-1].to_i if command.include?('down')
    aim -= command[-1].to_i if command.include?('up')
    break puts 'error' if depth < 0
  end
  horizontal * depth
end

input = YAML.load_file('day_2.yml').scan(/[a-z]+[ ]\d/)
p calculate_position(input)