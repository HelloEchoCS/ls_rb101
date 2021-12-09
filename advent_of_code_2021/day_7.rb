require 'yaml'
require 'pry'

positions = YAML.load_file('day_7.yml')
# raw_data = [16,1,2,0,4,2,7,1,2,14]
# positions = raw_data.to_s.split("").map { |str| str.to_i }

=begin
A
- calculate the min and max number in the `positions`
- iterate through min to max, for each number:
  - iterate through each position:
    - calculate the distance between the number and the position:
    - distance = position - number
    - if distance < 0, distance = 0 - distance
    - distances << distance
  - end
  fuel_possibilities << distances.sum
- end

fuel_possibilities.min

=end

def cal_fuel_possibilities(arr)
  initial_pos = arr.min
  max = arr.max
  fuel_possibilities = []
  while initial_pos <= max
    fule_consumptions = []
    arr.each do |position|
      distance = position - initial_pos
      distance = 0 - distance if distance < 0
      fuel =  (1 + distance) * distance / 2
      fule_consumptions << fuel
    end
  fuel_possibilities << fule_consumptions.sum
  initial_pos += 1
  end
  fuel_possibilities
end

=begin
A
- calculate the min and max number in the `positions`
- iterate through min to max, for each number:
  - iterate through each position:
    - calculate the distance between the number and the position:
    - distance = position - number
    - if distance < 0, distance = 0 - distance
    - calculate fuel consumption for this distance
    - fule_consumptions << fuel
  - end
  fuel_possibilities << fule_consumptions.sum
- end

fuel_possibilities.min

A: calculate fuel consumptions
fuel = (distance + 1) * distance / 2
=end

p cal_fuel_possibilities(positions).min