=begin
P
- take a sentence string as input
- return the same string, but:
  - change the word represent a number (one, two, six, etc.) to the actual digit

D
- input: string
- output: string
- constant: word - digit hash

A
- break down the string into an array by " "
- iterate through every word in the array with index,
  - find the word in the word - digit hash, if found,
    - index reassign the word to it's digit form
- join the array using " "

=end

WORD_DIGIT = { "one" => "1",
               "two" => "2",
               "three" => "3",
               "four" => "4",
               "five" => "5",
               "six" => "6",
               "seven" => "7",
               "eight" => "8",
               "nine" => "9",
               "zero" => "0" }

=begin
- initialize a new array 'words_new'
- initialize a new array 'numbers'
- iterate through words, for each element:
  - check to see if the element is an int
    - if yes, add it to 'numbers', then check the next element of 'words' array
      - if the element is still a number, do nothing
      - if not,
        - join 'numbers' then add to 'words_new'
        - reassign 'numbers' to []
    - if not, add it to 'words_new'
- return 'words_new'
=end

def word_to_digit(str)
  words = str.split(" ")
  words.each_with_index do |word, index|
    if WORD_DIGIT.any? { |k, _| k == word }
      words[index] = WORD_DIGIT[word]
    elsif WORD_DIGIT.any? { |k, _| word.include?(k) }
      chars = word.chars
      removed = chars.pop
      words[index] = WORD_DIGIT[chars.join] + removed
    end
  end
  words_new = []
  numbers = []
  words.each_with_index do |word, index|
    if word[0].to_i.to_s == word[0]
      numbers << word
      if words[index + 1][0].to_i.to_s != words[index + 1][0]
        format_phone_number(numbers) if is_phone?(numbers)
        words_new << numbers.join
        numbers = []
      end
    else
      words_new << word
    end
  end

  words_new.join(" ")
end

def is_phone?(arr)
  arr.length == 10
end

def format_phone_number(arr)
  arr.insert(0, "(").insert(4, ") ").insert(8, "-")
end

p word_to_digit('Please call me at five five five one two three four five seven zero. Thanks.')
