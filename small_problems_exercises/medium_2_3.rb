=begin

P
a method takes a string, returns a hash contains the percentage of lowercase, uppercase characters, as well as characters that are neither of those two.
- input: string
- output: hash
- rules:
  - The string contains at lease one character
  - space is considered as a character
  - a number is neither uppercase or lowercase
  - the percentage has one decimal

D
- input: string
- output: hash (symbol => float)

A
- initalize empty hash "result"
- get the length of the string
- iterate through the string, for each character in the string:
  - if the character >= 'a' and <= 'Z'
    - if its in uppercase, add 1 to count_uppercase
    - if its in lowercase, add 1 to count_lowercase
  end if
- end
- result[:lowercase] = count_lowercase.to_f * 100 / length
- result[:uppercase] = count_uppercase.to_f * 100 / length
- result[:neither] = 100 - result[:lowercase] - result[:uppercase]

=end


def letter_percentages(str)
  length = str.length
  count_uppercase = 0.0
  count_lowercase = 0.0
  result = {}
  length.times do |n|
    if str[n] >= 'A' && str[n] <= 'z'
      count_uppercase += 1 if str[n].upcase == str[n]
      count_lowercase += 1 if str[n].downcase == str[n]
    end
  end
  result[:lowercase] = (count_lowercase * 100 / length).round(1)
  result[:uppercase] = (count_uppercase * 100 / length).round(1)
  result[:neither] = 100 - result[:lowercase] - result[:uppercase]
  result
end

p letter_percentages('abcdefGHI')