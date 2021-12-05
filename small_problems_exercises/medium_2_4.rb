=begin
P
- a method takes a string as an argument, returns true if all parentheses in the string are balanced. Otherwise, return false.
- input: string
- output: boolean
- rules:
  - '(' and ')' should be equal in number
  - '(' and ')' should occur in pairs, start with '('
  - if no '(' and ')', return true

A
- initialize 'left' and 'right'
- iterate through the string, for each character:
  - if it's '(', add 1 to 'left'
  - if it's ')', add 1 to 'right'
  - if 'right' > 'left', return false
- if 'left' == right, return true
- return false otherwise

=end

def balanced?(str)
  left = 0
  right = 0
  str.length.times do |n|
    left += 1 if str[n] == '('
    right += 1 if str[n] == ')'
    return false if right > left
  end
  return true if left == right
  false
end

p balanced?('What (is) this?') == true
p balanced?('What is) this?') == false
p balanced?('What (is this?') == false
p balanced?('((What) (is this))?') == true
p balanced?('((What)) (is this))?') == false
p balanced?('Hey!') == true
p balanced?(')Hey!(') == false
p balanced?('What ((is))) up(') == false
