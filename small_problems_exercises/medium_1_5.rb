=begin
P:
- input: odd int n
- output: a 4-pointed diamond in a n * n grid
- rules:
  - int n will represent the longest line in the diamond, which consists of n "*"s

D:
- input: odd int
- output: multiple lines of spaces and stars

A:
- set i = 1
- while i <= int
  - puts i "*"s, center it in the length of int
  - i += 2
- while i >= 1
  - i -= 2
  - puts i "*"s, center it in the length of int

=end

def diamond(int)
  puts "*".center(int)
  i = 1
  while i <= int - 2
    line = "*" + " " * i + "*"
    puts line.center(int)
    i += 2
  end
  i = int - 2
  while i > 1
    i -= 2
    line = "*" + " " * i + "*"
    puts line.center(int)
  end
  puts "*".center(int)
end

diamond(5)