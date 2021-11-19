=begin
Write a method that takes two arguments, a string and a positive integer, and prints the string as many times as the integer indicates.

Problem:
- input: a string and a positive integer
- output: the string as many times as the integer indicates
- requirements:
  -

- questions:
  - do I need to worry about empty input?
  - do I need give input such as a negative integer special treatment?



test case:
repeat('Hello', 3)
=>Hello
Hello
Hello

data structure
- input: string & positive integer
- output: multiple lines of the same string

algorithm
- get a string and an integer passed in as arguments
- loop n times, n equals to the passed in integer
    - puts the passed in string

=end

def repeat(string, print_times)
  print_times.times { puts string}
end

repeat('Hello', 3)