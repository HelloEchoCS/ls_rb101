def sum(n)
  (1..n).reduce(:+)
end

def product(n)
  (1..n).reduce(:*)
end

puts "Please enter an integer greater than 0:"
input_int = gets.chomp.to_i
puts "Enter 's' to compute the sum, 'p' to compute the product."
compute_method = gets.chomp
puts "The sum of the integers between 1 and #{input_int} is #{sum(input_int)}." if compute_method == 's'
puts "The product of the integers between 1 and #{input_int} is #{product(input_int)}." if compute_method == 'p'
