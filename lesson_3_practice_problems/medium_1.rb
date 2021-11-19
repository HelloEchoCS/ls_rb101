# Q1
10.times { |n| puts("The Flintstones Rock!".rjust(21 + n)) }

# Q2
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{(40 + 2)}"

# Q3
def factors(number)
  factors = []
  number.times { |n| factors << number / (n + 1) if number % (n + 1) == 0}
  factors
end

# Q4

# Q5

# Q6
# the output would be 34

# Q7
# Yes, because Spot was using indexed assignment to mutate the value of both "age" and "gender" keys.
# As a result, the original hash values were mutated and changed.

# Q8
