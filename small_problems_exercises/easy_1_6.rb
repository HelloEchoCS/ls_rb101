=begin
Write a method that takes one argument, a string containing one or more words,
and returns the given string with words that contain five or more characters reversed.
Each string will consist of only letters and spaces.
Spaces should be included only when more than one word is present.

Problem
- input: a string
- output: the given string with words that contain five or more characters reversed
- requirements:



Algorithm:
- take one string as an argument
- split the given string into words " ",assign them to a new array
- for each word in the array,
  - check the length of the word
  - if the length is equal or more than 5, reverse the word(using destructive method)
- combine the words in the array into a new string, restore spaces between words
- return the string

=end

def reverse_words(input)
  words = input.split(" ")
  words.each { |word| word.reverse! if word.length >= 5 }
  words.join(" ")
end


puts reverse_words('Professional')          # => lanoisseforP
puts reverse_words('Walk around the block') # => Walk dnuora the kcolb
puts reverse_words('Launch School')         # => hcnuaL loohcS