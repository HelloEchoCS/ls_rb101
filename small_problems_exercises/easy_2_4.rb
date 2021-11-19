year = Time.now.year

puts "What is your age?"
age = gets.chomp.to_i
puts "At what age would you like to retire?"
retire_age = gets.chomp.to_i
retire_year = retire_age - age + year

puts "It's #{year}. You will retire in #{retire_year}."
puts "You have only #{retire_age - age} years of work to go!"