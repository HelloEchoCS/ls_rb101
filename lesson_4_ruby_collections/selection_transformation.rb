# produce = {
#   'apple' => 'Fruit',
#   'carrot' => 'Vegetable',
#   'pear' => 'Fruit',
#   'broccoli' => 'Vegetable'
# }

# def select_fruit(hash)
#   return_hash = {}
#   hash.each do |key, value|
#     return_hash = return_hash.merge({ key => value }) if value == 'Fruit'
#   end
#   return_hash
# end

# p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}

my_numbers = [1, 4, 3, 7, 2, 6]

def multiply(array, multiply_value)
  counter = 0
  output_array = []
  loop do
    break if counter == array.count

    current_number = array[counter]
    current_number *= multiply_value
    output_array << current_number
    counter += 1
  end
  p output_array
end

multiply(my_numbers, 3)