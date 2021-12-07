require 'yaml'
require 'pry'

raw_data = YAML.load_file('day_6.yml')
fishes = raw_data.to_s.split("").map do |fish|
  fish.to_i
end

=begin
A:
- initialize starting fishes
- day = 0
- iterate through 80 days, break when day > 80, for each day:
  - iterate through all the fishes, for each fish:
    - if the value == 0
      - add a new fish to another array 'new_fish', set the value to 8
      - set the value to 6
    else
      - reduce it's value by 1
    - end
  - end
  - combine current array with new_fish
  - day + 1
- end

- count the fish

=end

# def growing_fish(fishes)
#   day = 0
#   while day < 256 do
#     new_fishes = []
#     fishes.map! do |fish|
#       if fish == 0
#         new_fishes << 8
#         fish = 6
#       else
#         fish -= 1
#       end
#     end
#     day += 1
#     next if new_fishes.count == 0
#     fishes += new_fishes
#   end
#   fishes
# end


=begin

A
- each day, for each key in mature fish hash
  -




=end

def initialize_mature(fishes)
  mature_fishes = { 6 => 0, 5 => 0, 4 => 0, 3 => 0, 2 => 0, 1 => 0, 0 => 0 }
  fishes.each do |fish|
    mature_fishes[fish] += 1
  end
  mature_fishes
end

def initialize_new
  { 8 => 0, 7 => 0, 6 => 0, 5 => 0, 4 => 0, 3 => 0, 2 => 0, 1 => 0, 0 => 0 }
end


def sorting_fishes(mature_fishes, new_fishes)
  mature_fishes_new = {}
  new_fishes_new = {}
  mature_fishes_new[6] = mature_fishes[0] + new_fishes[0]
  mature_fishes_new[5] = mature_fishes[6]
  mature_fishes_new[4] = mature_fishes[5]
  mature_fishes_new[3] = mature_fishes[4]
  mature_fishes_new[2] = mature_fishes[3]
  mature_fishes_new[1] = mature_fishes[2]
  mature_fishes_new[0] = mature_fishes[1]

  new_fishes_new[8] = mature_fishes[0] + new_fishes[0]
  new_fishes_new[7] = new_fishes[8]
  new_fishes_new[6] = new_fishes[7]
  new_fishes_new[5] = new_fishes[6]
  new_fishes_new[4] = new_fishes[5]
  new_fishes_new[3] = new_fishes[4]
  new_fishes_new[2] = new_fishes[3]
  new_fishes_new[1] = new_fishes[2]
  new_fishes_new[0] = new_fishes[1]
  [mature_fishes_new, new_fishes_new]
end


p mature_fishes = initialize_mature(fishes)
p new_fishes = initialize_new

256.times do |n|
  everyday = sorting_fishes(mature_fishes, new_fishes)
  everyday
  mature_fishes = everyday[0]
  new_fishes = everyday[1]
end

p count = mature_fishes.values.sum + new_fishes.values.sum
