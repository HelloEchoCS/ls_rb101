=begin

P:
input: n, represents the location in a Fibo sequence
output: int, the actual nth Fibo number
rules:
- nth number in a Fibo sequence is the sum of the previous two numbers (n-2 and n-1)
- the first and second number in the sequence are both 1

D:
input: int
output: int

A(Recursive Method)
- if n == 2 || n == 1, return 1
- fibo num(n) = fibo num(n-1) + fibo num(n-2)\

A(Procedural Method)
- counter = 0
- first = 1
- second = 1
- while counter < n - 2
- current = first + second
- first = second
- second = current
- counter += 1
- end
- return current

=end

# def fibonacci(n)
#   return 1 if n <= 2
#   fibonacci(n - 1) + fibonacci(n - 2)
# end

# def fibonacci(n)
#   counter = 0
#   first = 1
#   second = 1
#   while counter < n - 2
#     current = first + second
#     first = second
#     second = current
#     counter += 1
#   end
#   current
# end

def fibonacci(n)
  first, last = [1, 1]
  3.upto(n) do
    first, last = [last, first + last]
    p last
  end
  last
end

def fibonacci_last(n)
  first, last = [1, 1]
  counter = n % 60
  3.upto(counter) do
    first, last = [last, first + last]
    last = last - 10 if last >= 10
  end
  last
end

def find_pattern(arr)
  arr.each_with_index do |n, index|
    return index if n == 1 && arr[index + 1] == 1
  end
end

p fibonacci_last(15)        # -> 0  (the 15th Fibonacci number is 610)
p fibonacci_last(20)        # -> 5 (the 20th Fibonacci number is 6765)
p fibonacci_last(100)       # -> 5 (the 100th Fibonacci number is 354224848179261915075)
p fibonacci_last(100_001)
p fibonacci_last(1_000_007) # -> 3 (this is a 208989 digit number)
p fibonacci_last(123456789) # -> 4
p fibonacci_last(123456789987745)

