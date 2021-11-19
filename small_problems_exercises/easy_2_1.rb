=begin
Build a program that randomly generates and prints Teddy's age. To get the age, you should generate a random number between 20 and 200.



=end
name = gets.chomp
name = 'Teddy' if name.empty?
puts "#{name} is #{rand(20..200)} years old!"