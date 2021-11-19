=begin
Write a method that takes one argument, a string, and returns a new string with the words in reverse order.

Problem:
- input: a string
- output: a new string with the words in reverse order
- requirements:
  - empty string results in an empty string output
  - any number of spaces results in an empty string output

Data Structures:
- input: a string
- output: a new string
- an array will be used to store all the words

Algorithm:
- take a string as an argument
- create a new string named "result"
- split the input string by space, assign all the words into a new array
- if the array is empty, return "result" as an empty string
- for each word in the array, prepend the word into a new array
- join all the words in the new array with a space within each other
- return "result"

=end

def reverse_sentence(input)
  result = ""
  words = input.split(" ")
  words_rev = []
  return result if words.empty?
  words.each { |word| words_rev.prepend(word) }
  words_rev.join(" ")
end

puts reverse_sentence('Hello World') == 'World Hello'
puts reverse_sentence('Reverse these words') == 'words these Reverse'
puts reverse_sentence('') == ''
puts reverse_sentence('    ') == '' # Any number of spaces results in ''


# def reverse_sentence(string)
#   string.split.reverse.join(' ')
# end