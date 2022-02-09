# Syntatical Sugar
```ruby
puts "hello"
```

This is a method invocation. The string "hello" is passing in as an argument.

```ruby
def str
  " a method"
end

p str
```
We are printing out the return value of the method invocation.

```ruby
str = "a string"

p str
```
We are printing out the value of str variable

```ruby
def str
  " a method"
end

str = "a string"

p str
```
In this case, str is going to reference the local variable

### Syntatical Sugar List
  - TBC

# Variables

- Explain local variable scope, especially how local variables interact with method invocations with blocks and method definitions.

## Local Variable Scope
- Variables initialized in the outside scope are accessible in the inner scope (or in the block).
- Variables initialized inside block/the inner scope are not accessible in an outer scope.

```ruby
str = "hello" # variable initialization

loop do
  str = "world" # variable re-assignment
  break
end
```
On `line 1` the local variable `str` is initialized to a string object `hello`. On `line 3-6`, we are calling `loop` method and passing in a `do...end` block as an argument. The `do...end` block followed by a method invocation creates an inner scope for local variables. Inside the block, the local variable `str` is reassigned to a new string object `world`. This reassignment is possible because local variables initialized from the outer scope are accessible from the inner scope.
The code does not have an output and returns `nil`.

```ruby
a = 4

loop do
  a = 5
  b = 3
  break
end

puts a
puts b
```
This code outputs `4` and throws an error: undefined local variable or method `b`.

On line 1 the local variable `a` is initialized to an integer object `4`. On `line 3-7`, the `loop` method is invoked and a `do...end` block is passed to it as an argument. The `do...end` block followed by a method invocation creates an inner scope for local variables. Inside the block, on `line 4` the local variable `a` is reassigned to a new integer object `5`. This is possible because `a` is initialized in the outer scope and is accessible from the inner scope. On `line 5`, the local variable `b` is initialized to an integer object `3` in the inner scope.

On `line 9`, we are invoking `puts` method and passing in local variable `a` as an argument. Since `a` is reassigned to an integer object `5`, this line outputs `5` and returns `nil`.
On `line 10`, we are invoking `puts` method again. This time, the local varible `b` is passed in as an argument. However, since local variable `b` is initialized in an inner scope, it's not available in the outer scope. Therefore, Ruby doesn't know what `b` is and raises an exception: undefined local variable or method `b`.

This example demonstrates the concept of local variable scoping rules. Specifically that variables initialized in the outer scope are accessible in the inner scope; Variables initialized in the inner scope are not available in the outer scope.

```ruby
a = 'hi'

def some_method
  puts a
end

some_method
```
The code raises an exception: undefined local variable or method `a`.

On line 1, the local variable `a` is initialized to a string object `hi`. On line 3-5 we define the method `some_method` and create a self-contained scope. Inside the method definition, `puts` method is invoked and passed local variable `a` as an argument. However, since local variables initialized in the outer scope are not accessible inside the method definition, when we are calling the `some_method` method on 7, Ruby will raise an exception: undefined local variable or methdo `a`.

This example demonstrates the concept of local variable scoping rules. Specifically that local variables initialized in the outer scope are not accessible inside the method definition.


## Variable Shadowing
When parameter name of the block is the same as the name of the local variable which was initialized outside of the block, variable shadowing prevents access to variables of the same name initialized outside of the block.

```ruby
a = 4
b = 2

2.times do |a|
  a = 5
  puts a
end

puts a
puts b
```
On line 1, the local variable `a` is initialized to an integer object `4`. On line 2, the local variable `b` is initialized to an integer object `2`.

On line 4-7, `times` method is called on the integer object `2`. The `do...end` block is passed in as an argument with the local variable `a` as the block parameter. Since the block parameter `a` has the same name as the local variable initialized in the outer scope, variable shadowing happens and prevents access to the local variable `a` initialized in the outer scope. Therefore, on line 5, the block parameter `a` is reassigned to an integer object `5`. On line 6, `puts` method is called and block parameter `a` is passed in as an argument. Since `a` is now assigned to the integer object `5`, this line outputs `5` . Because the block is executed twice, line 4-7 outputs `5` and `5` then returns `2`.

On line 9, we are calling `puts` method and passing in local variable `a` as an argument. Since local variable `a` is not changed, this line outputs the value `4` of the integer object `a` is pointing to.
On line 10, we are calling `puts` method and passing in local variable `b` as an argument. It outputs the value `2` of the integer object `b` is pointing to.

This example demonstrates the concept of variable shadowing. Specifically if we have a block parameter having the same name as the local variable initialized in the outer scope, variable shadowing prevents access to that local variable initialized in the outer scope.

## Mutating vs Non-mutating Methods / Pass By Reference vs Pass By Value
- Element assignment is mutating
- Element assignment is a mutating method, for example: `Array#[]=` is actually `Array.[](0, arg)`
- Only objects can be mutated, variables can't. Variables can be reassigned.
- Methods are calling on objects, not variables

```ruby
def amethod(param)
 param += " world"
end

str = "hello"
amethod(str)

p str
```
The `amethod` invocation on line 6 is going to return a new string object, and it has no effect on `str`.

```ruby
def amethod(param)
  param += " world" # re-assignment
  param + " world" # string concatenation (non-destructive method, it returns a new object). It does not mutate the calling object 'param'
  param << " world" # a distructive method that mutates the calling object
end

str = "hello"
amethod(str)

p str
```

```ruby
def amethod(param)
  param += " world"
  # param + " world"
  param << " world"
end

str = "hello"
amethod(str)

p str
```
On `line 2`, the variable `param` is re-assigned to a new string object returned by the string concatenation method which combine the string assigned to the variable `param` with the string " world". `param` no longer points to the same object as `str`
On `line 4`, the destructive method is performed on the new string object, which has nothing to do with the string object variable `str` is pointing to.
On `line 8`, `str` is passed to `amethod` as an argument, `param` is assigned to `str`
Therefore on `line 10`, the p method outputs "hello"

```ruby
a = "hello"
b = a
a += b
```
`a` is a local variable initialized to a string object with the value "hello"
- in other words, local variable `a` references the string object with the value "hello"
`b` is a local variable initialized and points to the same string object that the local variable `a` is referencing
`a` is re-assigned to a new object returned by method `+`

```ruby
def fix(value)
  value = value.upcase!
  value.concat('!')
end
s = 'hello'
t = fix(s)
```
On `line 2`, the variable `value` is reassigned to the return value of calling the mutating method `upcase!` on the object referenced by `value`.

## Variables As Pointers
Variables don't contain the value. They act as pointers to an address space in memory that contains the value.
If you call a method that mutates the caller, it will change the value in that object's address space, and any variables that point to that object will be affected.

```ruby
def test(b)
  b.map {|letter| "I like the letter: #{letter}"}
end

a = ['a', 'b', 'c']
test(a)
```
What is `a` after the `test` method returns? Explain why.



# Methods
- puts vs return
- method definition and method invocation
- implicit return value of method invocations and blocks

## puts vs return
Ruby methods ALWAYS return the evaluated result of the last line of the expression unless an explicit return comes before it.
```ruby
def add_threes
  number = 4
  number + 3
end
```
The assignment expression on line 2 evaluates to 4.
Line 3 evaluates to 7. Since it is the last evaluated expression and we don't have any explicit `return` inside the method definition, it is the return value of the method `add_threes`.

```ruby
def add_three(number)
  return number + 3
  number + 4
end

returned_value = add_three(4)
puts returned_value
```
This code outputs `7` and returns `nil`.

On line 6 we initiate the local variable `returned_value` to the return value of the method call `add_three` with the integer `4` passed in as an argument.
On line 1-4 we defined the method `add_three` with one parameter `number`. In this case, `number` is assigned to the passed in argument: integer `4`.
On line 2, the keyword `return` is used, so we explicitly return the evaluated result of `number + 3`, which is `7`, without executing the next line. Therefore, the method call `add_three(4)` on line 6 returns `7`. It is then assigned to the local variable `returned_value`.
On line 7, we are calling `puts` method and passing in `returned_value` as an argument, resulting in printing out the value `7` of the integer object `returned_value` is pointing to.

This example demonstrates the concept of explicit return value of the method invocation using the keyword `return`.

## Method Definition And Method Invocation
```ruby
def example(str)
  i = 3
  loop do
    puts str
    i -= 1
    break if i == 0
  end
end

example('hello')
```
On line 1-8 the method `example` is defined which takes one parameter `str`. On line 10 the method is called and a string `"hello"` is passed in as an argument. Upon the `example` method invocation, the method parameter `str` is now referencing the String object `"hello"` passed to the method.

On line 2 local variable `i` is initiated to an Integer object `3`. On line 3 we are calling the `loop` method and passing in `do...end` block as an argument. Inside the block, on line 4 we are calling `puts` method and passing in the local variable `str` to it as an argument, printing out the String object `"hello"` that `str` references. On `line 5`, the local variable `i` is reassigned to the return value of the method call `Integer#-` on a local variable `i` with the integer `1` passed to it as an argument. On `line 6`, the keyword `break` is used to break out of the loop when the the value of the Integer object that local variable `i` is referencing equals to 0.

This code outputs `"hello"` 3 times and returns `nil`.

## Method Side-effects vs Return Value
```ruby
def prefix(str)
  "Mr. " + str
end

name = 'joe'
prefix(name)

puts name
```
On `line 5`, the local variable `name` is initiated and assigned to the string object. On `line 7`, method `prefix` is called and `name` is passed in as an argument. Inside the method, the variable `str` is initialized and assigned to the same string object `name` is pointing to. However, nothing is done to this string object inside the method. Therefore, `name` is not affected. On `line 8`, `puts` is called to print the value of the string object name is pointing to which is 'joe'.

# Collections: Strings, Arrays And Hashes
Working with collections (Array, Hash, String), and popular collection methods (each, map, select, etc). Review the two lessons on these topics thoroughly.

Array: elememts are retrievable by index
Mostly we use symbol as the key in a hash, why?
Symble vs String: symbles are immutable strings.

- Referencing an out-of-bounds index using `[]` method returns `nil`. To avoid the ambiguity especially with Array, use `Array#fetch` instead.
- Elements in String and Array objects can be referenced using negative indices, starting from the last index in the collection `-1` and working backwards.

## Array

```ruby
arr = [1, 'two', :three, '4']
arr.slice(3, 1)
arr.slice(3..3)
arr.slice(3)
arr[4]
```
What are the return values on line 2-5?

## Hash
- The keys must be unique. The last key-value pairs will over-write others if they have identical keys.
- `Hash#keys` and `Hash#values` return an array.
- Hash has a `to_a` method that returns a nested array: [[key, value], [key, value], ...]

```ruby
arr = [1, 2, 3]

arr.each do |n|
  puts n
end
```
The block is passed in as an argument to the `each` method.
`each` will execute the block for every element in the array.

`select` returns a new array based on the return value of the block. If the return value evaluates to true, then the element is selected and put into a new array.

`map` returns a new array based on the return value of the block. Each element is transformed based on the return value.

```ruby
arr = [1, 2, 3]
hsh = {}
arr << hsh
hsh[:f] = 6

p arr
```
This code outputs [1, 2, 3, {:f => 6}] and returns nil.
On `line 1` the local variable `arr` is initialized and assigned to an array object with value `[1, 2, 3]`.
On `line 2` the local variable `hsh` is initialized and assigned to an empty hash object.
On `line 3` we are calling the destructive `Array#<<` method on the local variable `arr` and passing in `hsh` as an argument. The caller `arr` is mutated and it's pointing object value becomes [1, 2, 3, {}].
On `line 4` we are calling the indexed assignment method `Hash#[]=` on the local variable `hsh` and mutate the caller. Since the value of the object `hsh` is pointing to is also part of the value of the object `arr` is pointing to, mutating the Hash `hsh` will also permanently mutate the Array `arr`.
Therefore, on `line 6`, we are calling `puts` method and passing in the local variable `arr` as an argument, resulting in printing out the value of the Array object where `arr` is referencing, which is now [1, 2, 3, {:f => 6}].

# Truthiness
```ruby
a = "Hello"

if a
  puts "Hello is truthy"
else
  puts "Hello is falsey"
end
```
This code outputs `"Hello is truthy"` and returns `nil`.
The local variable `a` is initialized to the string `"Hello"` on line 1. Since `a` itself is evaluated as true in the conditional statement on line 3-7, the `puts` method on line 4 is invoked, outputs `"Hello is truthy"` and returns `nil`.

This example demonstrates the concept of truthiness. Specifically that every expression other than `false` and `nil` are evaluated as true.

# Sorting

Comparison is at the heart of how sorting works. We need to know if the objects has the `<=>` method implemtation, and how such method is defined.

Method `<=>`:
`a <=> b`
- returns 1 if a < b
- returns -1 if a > b
- returns 0 if a == b
- returns `nil` if a and b are not comparable

When comparing multi-characters string, the comparison is done character by character. If both characters are the same then the next characters in the strings are compared. If the comparable characters are all equal, the longer string is considered to be greater.

When comparing arrays, the comparison is done in an element-wise manner.

## Array#sort



# Practice

```ruby
def my_method(str)
  i = 0
  puts str
end

my_method('hello')
```
This code outputs `hello` and returns `nil`
On `line 6`, we are calling `my_method` and passing in the string object `'hello'` as an argument.
On `line 1-4` the method `my_method` is defined with one parameter `str`.
Inside the `my_method` method, the passed in string object `'hello'` is assigned to `str`. Then we are calling `puts` method and passing in `str` as an argument. It prints out the value `'hello'` of the string object `str` is pointing to.

Question: Consider the code below. Explain why line 8 returns 7 rather than 12? What concept does this demonstrate?
```ruby
num = 12

3.times do |_|
    num = 7
    break
end

num #=> 7
```
On `line 1` the local variable `num` is initiated to an integer `12`. On `line 3-6` the method `Integer#times` is called on the integer object `3`, and a `do...end` block is passed in as an argument. The `do...end` block followed by method invocation creates a new inner scope for local variables. Inside the block the local variable `num` is reassigned to a new integer `7`. This reassignment is possible because local variables initialized in the outer scope are accessible from the inner scope.

Therefore, on line `8`, the local variable `num` returns `7`.

This example demonstrates the concept of local variable scoping rules. Specifically that variables initialized in the outer scope are accessible in the inner scope.

```ruby
def test(str)
  str  += '!'
  str.downcase!
end

test_str = 'Written Assessment'
test(test_str)

puts test_str
```
The local variable `test_str` is initialized to the String object `"Written Assessment"` on line 6. On line 7 we are calling `test` method and passing in `test_str` as an argument. Upon the `test` method invocation, the method parameter `str` is now referencing the same String object `test_str` references. On line 2, we are calling `String#+` method on `str` and passing in String object `"!"` as an argument, returning a new String object `"Written Assessment!"`. Then `str` is reassinged to this new String object. Form now on the local variable `str` is pointing to a different object from `test_str`, any further changes to `str` won't affect the object that `test_str` references.

On line 9 we are calling `puts` method and passing `test_str` as an argument. Since the String object that `test_str` references is not mutated, it's value `"Written Assessment"` is what the output is.

This example demonstrates the concept of variables as pointers as well as mutating vs. non-mutating methods. Specifically that non-mutating methods return a new object without mutating the caller, and reassignment causes the local variable points to a different object in memory.

```ruby
def repeater(string)
  result = ''
  string.each_char do |char|
    result << char << char
  end
  result
end

repeater('Hello')
```
This code returns `'HHeelllloo'` on line 9.

On line 9, `repeater` method is invoked with string `'Hello'` passed in as an argument. `repeater` is defined on line 1-7 with one parameter `string`. Upon invocation, `string` now references the string `'Hello'`. On line 2 the local variable `result` is initialized to an empty String object. On line 3, `each_char` method is invoked on `string`, a `do...end` block with parameter `char` is passed to it as an argument. `each_char` method iterates over each character of `'Hello'`, assigns the character to the block parameter `char`, then runs the block. On line 4, we are calling the destructive method `String#<<` on `result` twice, and mutates the String object `result` references by concatenating the character `char` references to it two times.

Upon completion of the iteration, `each_char` method returns the collection it iterates over. Line 6 evaluates to the String object `result` is referencing. Since this is the last evaluated line in the method definition, String object `'HHeelllloo'` is returned.

```ruby
x = "hi there"
my_hash = {x: "some value"}
my_hash2 = {x => "some value"}
```
On line 1, the local variable `x` is initialized to String `"hi there"`. On line 2, the local variable `my_hash` is initialized to a Hash object with one key-value pair: Symbol object `:x` as key and String object `"some value"` as value. On line 3, the local variable `my_hash2` is initialized to a Hash object with one key-value pair: the local variable `x` as key and String `"some value"` as value.

```ruby
total = 0
[1, 2, 3].each do |number|
  total += number
end
puts total
```
On line 1, the local variable `total` is initialized to the integer `0`. On line 2, `Array#each` method is invoked on the array `[1, 2, 3]` and a block is passed as an argument. During the iteration, the block parameter `number` is assigned to each element of the calling array object. On line 3, the `Interger#+` method is called on `total` and passing in `number` as an argument. Then `total` is reassigned to the return value of the `+` method. When the iteration is finished, `total` is referencing the integer `6`.
On line 5, the `puts` method is called, passing in `total` as an argument. Since integer `6` is now referenced by `total`, Integer `6` is printed and `nil` is returned.

```ruby
def test(b)
  b.map {|letter| "I like the letter: #{letter}"}
end

a = ['a', 'b', 'c']
test(a)
```
On line 5, the local variable `a` is initialized to an Array object `['a', 'b', 'c']`. On line 6, we are calling `test` method and passing in `a` as an argument. The `test` mehtod is defined on line 1-3 with one parameter `b`. Upon the method invocation, `b` is referencing the same Array object `a` references. On line 2, we are calling `Array#map` method on the local variable `b` and passing in a block as an argument. The block parameter `letter` is assigned to the current element of the calling Array object. Upon each iteration and executing of the block, the object `letter` references is embedded into the string around it via the string interpolation expression `#{letter}`. This resulting string is returned from the block and added to the new array object returned by `map` method. The `test` method invocation with local variable `a` on line 6 returns the new array.

```ruby
def include?(arr, search_item)
  !arr.each { |item| return true if item == search_item }
end

include?([1, 2, 3, 4, 5], 6)
```
On line 5, we are invoking the method `include?` defined on line 1-3 and passing in an array object `[1, 2, 3, 4, 5]` and an integer `6` as two arguments. Upon the method invocation, the method parameter `arr` is referencing the passed in array object, and parameter `search_item` is referencing the passed in integer. On line 2, we are calling the `each` method on the local variable `arr` and passing in a block as an argument. The block parameter `item` will be assigned to the current element in the Array object that `arr` references in each iteration.

Upon each iteration and executing of the block, if `item` is equal to the local variable `search_item`, we use `return` keyword and explicitly return a boolean value `true` and finish the method invocation.

On the other hand, if `item` never equals to `search_item` and the iteration is completed, we are now evaluting the truthiness of the return value of the `each` method, and using a `!` opperator to reverse the result of the evaluation. Since `each` method returns the caller `arr`, which is evaluated as `true`, this line as well as the method returns `false`.

Since none of the element in the array object `[1, 2, 3, 4, 5]` that `arr` references is equal to the integer `6` that `search_item` references, the `include?` method returns `false` on line 4.

```ruby
def merge(array_1, array_2)
  array_1 | array_2
end

arr1, arr2 = ['hello'], ['hello', 'world']
merged = merge(arr1, arr2)
merged[0][0] = 'J'
p merged
p arr1
p arr2
```
On line 5, local variables `arr1` and `arr2` are initialized to array objects `['hello']` and `['hello', 'world']` respectively. On line 6, the local variable `merged` is initialized to the return value of the method `merge` invocation with `arr1` and `arr2` passed in as arguments. On line 1, method parameters `array_1` and `array_2` are referencing the same objects that `arr1` and `arr2` reference, respectively.

On line 2, we are calling `Array#|` method on `array_1` and passing in `array_2` as an argument, returning a new Array `['hello', 'hello world']`. Noted that the first and second String element in the array are the same String object that `arr1` and `arr2` is referencing, respectively. This new array is also the return value of the method `merge` since this is the last evaluated expression in the method definition.

As a result, on line 6, the local variable `merged` is initialized to the array object `['hello'], ['hello', 'world']`.

On line 7, we are calling the method `Array#[]` on `merged` and accessing the element in it indexed at `0`, which is the String object `hello`. Then we call the destructive `String#[]=` method on `merge[0]` and pass in the String `J` as an argument, resulting in replacing the first character of the String object `hello` to `'J'`. This change is also reflected on `arr1` that is referencing this string object `'hello'`

As a result, on line 8-10, we are calling `p` method and passing in `merged`, `arr1` and `arr2` respectively, outputing `['Jello', 'world']`, `['Jello']` and `['hello', 'world']` respectively.


```ruby
a = 'Hello'
b = a
a = 'Goodbye'
puts a
puts b
```
The code outputs `Goodbye` and `Hello`, returns `nil`.
On line 1, the local variable `a` is initialized to String `Hello`. On line 2 the local variable `b` is initialized to the same String object `a` is pointing to. On line 3 the local variable `a` is reassigned to a new String object `Goodbye`. As a result, when we are calling `puts` method and passing `a` as an argument, `Goodbye` is printed out and this line returns `nil`. Similarly, on line 5, `Hello` is the output and `nil` gets returned.
This example demonstrates the concept of Variables as Pointers in Ruby. Specifically, variables in Ruby act as references to the actual object in the memory.

```ruby
a = 4

loop do
  a = 5
  b = 3


  break
end

puts a
puts b
```
This code outputs `5` then raise an exception: undefined local variable or method `b`.
On line 1, the local variable `a` is initialized to Integer `4`. On line 3-9, we are calling `loop` method and passing in a block as an argument. The block followed by method invocation creates an inner scope for local variables. On line 4, the local variable `a` is reassigned to `5`. On line 5, another local variable `b` scoped to the block is initialized to the Integer `3`.
On line 11, we are calling `puts` method and passing `a` as an argument, outputs `5` and returns `nil`.
However, since Ruby cannot access the local variable `b` from the outer scope, on line 12 we will get an error message by calling `puts` method and passing `b` as an argument.
This example demonstrates Ruby's Variable Scoping Rules. Specifically that variables initialized in the inner scope is not available in the outer scope.

```ruby
a = 4
b = 2

loop do
  c = 3
  a = c
  break
end

puts a
puts b
```
This code outputs `3` and `2`, and returns `nil`.
On line 1, the local variable `a` is initialized to Integer `4`. On line 2, the local variable `b` is initialized to Integer `2`. On line 4-8, we are calling `loop` method with a block. The block following a method invocation creates an inner scope for local variables. On line 5, the variable `c` local to the block is initialized to Integer `3`. On line 6, the local variable `a` is reassigned to the Integer `3` that `c` is pointing to. As a result, on line 10, we are calling `puts` method and passing `a` as an argument, printing out `3` and returns `nil`. Similarily, on line 11, the output is `2` and the return value is `nil`.
This example demonstrates the concept of Variable Scoping Rules. Specifically that variables initialized in the outer scope are available in the inner scope.

```ruby
def example(str)
  i = 3
  loop do
    puts str
    i -= 1
    break if i == 0
  end
end

example('hello')
```
This code outputs `hello` three times and returns `nil`.
On line 10, we are calling `example` method and passing in string object `hello` as an argument. Upon the invocation of the method, the local variable `str` is also initialized to the String object `hello`. On line 2, the local variable `i` is initialized to `3`. On line 3-7, we are calling `loop` method with a block. The block will keep being executed until `i` equals `0`. Inside the block, we are calling `puts` method and passing in `str` as an argument, outputing the string object that `str` is pointing to. We are also calling the `-` method on the local variable `i` and passing in `1` to it, then reassigning the local variable `i` to the return value of the `-` method, which resulting in `i` being substracted by 1 in each iteration. The block is executed three times until `i` equals `0`.
This example demonstrates the concept of Loops by using the `loop` method with a block. Specifically that we can control the loop execution by using the `break` keyword.

```ruby
def greetings(str)
  puts str
  puts "Goodbye"
end

word = "Hello"

greetings(word)
```
This code outputs `"Hello"` and `"Goodbye"`, and returns `nil`.
On line 6, the local variable `word` is initialized to string `"Hello"`. On line 8, we are calling `greetings` method and passing in `word` as an argument. Upon the invocation of the method, the variable `str` local to the scope of the method is initialized to the same string object `"Hello"` that `word` is pointing to. Then on line 2 and 3, we are calling `puts` method and passing in `str` and `"Goodbye"` respectively, resulting in outputing `"Hello"` and `"Goodbye"`, and returns `nil`.
This example demostrates the concept of method definition and method invocation. Specifically that we can use parameters to get access to data outside of method definition's scope by passing in arguments during the method invocation.

```ruby
arr = [1, 2, 3, 4]

counter = 0
sum = 0

loop do
  sum += arr[counter]
  counter += 1
  break if counter == arr.size
end

puts "Your total is #{sum}"
```
This code outputs `"You total is 10"` and returns `nil`.
On line 1, the local variable `arr` is initialized to the Array object `[1, 2, 3, 4]`. On line 3 and 4, local variables `counter` and `sum` are initialized to Integer `0`. On line 5-9, we are calling `loop` method with a block. Inside the block, on line 6, we are incrementing `sum` by each element of `arr` through calling `+` method on `sum` and passing in the element of `arr` indexed at `counter` as an argument, then reassigning `sum` to the return value of the `+` method. On line 7, we are incrementing `counter` by 1 by calling `+` method again on `counter` and passing in `1` as an argument. On line 8, we are using the `break` keyword to stop the iteration when `counter` equals the number of elements in the array that `arr` is pointing to. The loop will iterate four times.
Finally, on line 11, we are calling `puts` method and passing in the string with `sum` embbeded into it using the string interpolation expression `#{sum}`, resulting in outputing `"You total is 10"` and returns `nil`.

```ruby
a = 'Bob'

5.times do |x|
  a = 'Bill'
end

p a
```
This code outputs `"Bill"` and returns `"Bill"`.
On line 1, the local variable `a` is initialized to the String `"Bob"`. On line 3, we are calling `times` method on `5` and passing in a block as an argument with the block parameter `x`. The block followed by method invocation creates an inner scope for local variables. Inside the block, the local variable `a` is reassigned to the string `"Bill"`. The block is executed five times.
Finally, on line 7, we are calling `p` method as passing in `a` as an argument. Since now `a` is pointing to the string object `"Bill"`, this line outputs `"Bill"` and returns `"Bill"`.
This example demostrates Loop using `times` method, as well as Ruby's Variable scoping rules. Specifically that variables initialized in the outer scope are available in the inner scope.

```ruby
animal = "dog"

loop do |_|
  animal = "cat"
  var = "ball"
  break
end

puts animal
puts var
```
This code outputs `"cat"` then raise an exception "undefined local variable or method `var`".
On line 1, the local variable `animal` is initialized to the string `"dog"`. On line 3-7, we are calling the `loop` method with a block. The block followed by method invocation creates an inner scope for local variables. As a result, on line 4, the local variable `animal` is reassgined to the string `"cat"`, and when we are calling `puts` method and passing `animal` as an argument on line 9, it outputs `"cat"` and returns `nil`. However, since the local variable `var` is initialized inside the block (the inner scope), this variable is not available in the outer scope. That's why when we are calling `puts` method and passing in `var` as an argument from the outer scope on line 10, Ruby can not find the local variable or method named `var` and raises an exception.
This example demonstrates the variable scoping rules. Specifically that variables initialized in the inner scope are not available in the outer scope, but variables initialized in the outer scope are available in the inner scope.

```ruby
a = 4
b = 2

2.times do |a|
  a = 5
  puts a
end

puts a
puts b
```
This code outputs `5`, `5`, `4` and `2` then returns `nil`.
On line 1 and 2, local variables `a` and `b` are initialized to `4` and `2` respectively. On line 4-7, we are calling `times` method on `2` and passing in a block as an argument. The block followed by method invocation creates an inner scope for local variables. However, variable shadowing prevents access the variable of the same name intialized in the outer scope. Therefore, on line 5, the variable `a` local to the block is initialized and then reassigned to `5`. `5` is then printed out twice via calling the `puts` method when the block is executed two times. On line 9, we are calling `puts` method and passing in `a`, which is initialized in the outer scope, as an argument, resulting in outputing `4` and returning `nil`. Similarily, on line 10, `2` is the outputs and the code returns `nil`.
This example demonstrates the concept of variable shadowing. Specifically that variables initialized in the outer scope that has the same name as the variable initialized in the inner scope are not available in the inner scope.

we are calling `times` method on Integer `5` and passing in a block with the prameter `a` as an argument. The local variable `a` is assigned to values from `0` to `4` each time the block is executed.

```ruby
n = 10

1.times do |n|
  n = 11
end

puts n
```
This code outputs `10` and returns `nil`.
On line 1, the local variable `n` is initialized to integer `10`. On line 3-5, we are calling `times` method on integer `1` and passing in a block with parameter `n` as an argument. The block followed method invocation creates an inner scope for local variables. However, variable shadowing prevents the access to the variable of the same name that initialized in the outer scope. As a result, the varibale `n` local to the block is initialized and reassigned to integer `11` on line 4. The value of the local variable `n` initialized in the outer scope remains `10`
When we are calling `puts` method in the outer scope and passing `n` as an argument, the output is `10` and returns `nil`.
This example demonstrates the concept of variable shadowing: When the variable initialzed in the inner scope has the same name as the variable initialized in the outer scope, variable shadowing prevents access to variables of the same name that initialized in the outer scope.

```ruby
animal = "dog"

loop do |animal|
  animal = "cat"
  break
end

puts animal
```
This code outputs `"dog"` and returns `nil`.
On line 1, local variable `animal` is initialized to string `"dog"`. We are calling `loop` method and passing in a block with parameter `animal` as an argument. The block followed by method invocation creates an inner scope for local variables. However, variable shadowing prevents the access to the local variable with the same name that initialized in the outer scope. As a result, on line 4, the variable local to the inner scope is initalized to the string `"cat"`, leave the local variable `animal` that initialized in the outer scope untouched. On the last line, we are calling `puts` method and passing in `animal` as an argument. Since `animal` in untouched, the output is `"dog"` and the return value is `nil`.
This example demonstrates the concept of variable shadowing. Specifically that variable shadowing prevents the access to the local variable with the same name that initialized in the outer scope.

```ruby
a = "hi there"
b = a
a = "not here"
```
On line 1, the local variable `a` is initalized to string `"hi there"`. On line 2, the local variable `b` is initalized to the same string object that `a` is pointing to. On line 3, the local variable `a` is reassigned to a different string object `"not here"`.
This example demonstrates the concept of variables as pointers. Specifically that variables in Ruby act as pointers to objects stored in the memory. the assignment operator `=` causes variables to point to a different object in the memory.

```ruby
a = "hi there"
b = a
a << ", Bob"
```
`a` and `b` are both `"hi there, Bob"`.
On line 1, the local variable `a` is initialized to the string `"hi there"`. On line 2, the local variable `b` is initialized to the same string object that `a` is pointing to. On line 3, we are calling the destructive `String#<<` method and passing in string `", Bob"` as an arguemnt, mutating the string object `a` is referencing to `"hi there, Bob"`.
This example demonstrates the concept of variables as pointers. Specifically that variables in Ruby act as pointers to objects stored in the memory. Mutating a object with detructive methods will affect all the variables that are referencing this object.

```ruby
a = [1, 2, 3, 3]
b = a
c = a.uniq
```
`a` and `b` are both `[1, 2, 3, 3]`. `c` is `[1, 2, 3]`.
On line 1, the local variable `a` is initialized to the array object `[1, 2, 3, 3]`. On line 2, the local variable `b` is initialized to the same array object that `a` is referencing. On line 3, we are calling the non-mutating `uniq` method on `a`, returning a new array object `[1, 2, 3]`. Then the local variable `c` is initialized to this new array object. Now the local variable `c` is referencing the different array object from `a` and `b`.
This example demonstrates the concept of variables as pointers and non-mutating methods. Specifically that variables in Ruby act as pointers to objects stored in the memory, and non-mutating methods return a new object without mutating the caller.

```ruby
def test(b)
  b.map {|letter| "I like the letter: #{letter}"}
end

a = ['a', 'b', 'c']
test(a)
```
`a` is `['a', 'b', 'c']`.
On line 5, the local variable `a` is initialized to an array object `['a', 'b', 'c']`. On line 6, we are calling `test` method and passing in `a` as an argument. Upon the method invocation, the variable `b` local to the scope of the method is initialized to the same array object that `a` is referencing. Inside the method definition, we are calling the non-mutating `map` method on `b` and passing in a block as an argument. This method call returns a new array and leave the calling object, which is the array `['a', 'b', 'c']` that both `a` and `b` are referencing unchanged.
As a result, after calling the `test` method on line 6, `a` is still pointing to the array object `['a', 'b', 'c']`.
This example demonstrates the concept of variables as pointers, as well as non-mutating methods. Specifically that variables in Ruby act as pointers to objects stored in the memory, and a non-mutating method returns a new object without mutating the caller.

```ruby
a = 5.2
b = 7.3

a = b

b += 1.1
```
`a` is `7.3`, `b` is `8.4`.
On line 1 and 2, local variables `a` and `b` are initialized to integers `5.2` and `7.3` respectively. On line 4, the local variable `a` is reassigned to the same integer `7.3` that `b` is referencing. Line 6 is effectively `b = b + 1.1`. As a result, `b` is reassgined to the return value of `b + 1.1`, which is integer `8.4`.
This example demonstrates the concept of variables as pointers. Specifically that variables in Ruby act as pointers to objects stored in the memory. Using the assignment operator `=` causes a variable to point to a different object.

```ruby
def test(str)
  str  += '!'
  str.downcase!
end

test_str = 'Written Assessment'
test(test_str)

puts test_str
```
This code outputs `"Written Assessment"` and returns `nil`.
On line 6, the local variable `test_str` is initialized to the string `"Written Assessment"`. On line 7, we are calling `test` method and passing in `test_str` as an argument. Upon the method invocation, the variable `str` local to the scope of the method is initialized to the same string object `test_str` is pointing to. On line 2, the local variable `str` is reassigned to a new string object `"Written Assessment!"`. Any further actions on `str` will not have an effect on the original string object that `test_str` is pointing to. As a result, when we are calling `puts` method and passing in `test_str` as an argument, the string `"Written Assessment"` is the output and this line returns `nil`.
This example demonstrates the concept of variables as pointers. Specifically that variables in Ruby act as pointers to objects located in the memory. When we are using the assignment operator `=`, it causes a variable to point to a different object.

```ruby
def plus(x, y)
  x = x + y
end

a = 3
b = plus(a, 2)

puts a
puts b
```
This code outputs `3` and `5`, returns `nil`.
On line 5, the local variable `a` is initialized to the integer `3`. On line 6, the local variable `b` is initialized to the return value of calling the method `plus` and passing in `a` and integer `2` as arguments. Upon the method invocation, variables `x` and `y` that local to the scope of the method are initialized to `3` and `2` respectively. Line 2 evaluates to the result of adding `3` and `2`, which is `5`. Since this is the last evaluated line of the method `plus`, it returns `5`. As a result, the local variable `b` is initialized to `5`. When we are calling `puts` method and passing in `a` and `b` respectively, `3` and `5` are the output and the return value is `nil`.
This example demonstrates the concept of object passing. Specifically that, when we call a method with arguments, Ruby reduce those arguments to objects, and makes them available inside the method

```ruby
def increment(x)
  x << 'b'
end

y = 'a'
increment(y)

puts y
```
This code outputs `"ab"` and returns `nil`.
On line 5, the local variable `y` is initialized to the string `"a"`. On line 6, we are calling `increment` method and passing in `y` as an argument. Upon the method invocation, variable `x` local to the scope of the method is initialized to the same string object `"a"` that `y` is pointing to. On line 2, we are calling the destructive method `String#<<` on `x` and passing in string `"b"` as an argument, resulting in the string object both `x` and `y` are pointing to being mutated to `"ab"`. Therefore, on the last line, when we are calling `puts` method and passing in `y` as an argument, the output is `"ab"` and the return value is `nil`.
This example demonstrates the concept of variables as pointers. Specifically that variables in Ruby act as pointers to objects located in the memory. When we are calling a mutating method on an object, it will affect all the variables that are pointing to the object.

```ruby
def change_name(name)
  name = 'bob'      # does this reassignment change the object outside the method?
end

name = 'jim'
change_name(name)
puts name
```
The reassignment in the method definition does not change the object outside the method. The reason is that reassignemnt is non-mutating. When we reassign a variable to an object, we merely cause the variable to point to this object. This action will not change the original object that the variable was pointing to. Additionally, in this case, the local variable `name` that is initalized in the outer scope is not the same variable `name` initialized in the scope of the method because method invocation in Ruby creates a self-contained scope, variables initialized in the outer scope are not available inside the method. As a result, both the reference of the local variable `name` in the outer scope, and the object it is referencing are not changed.

```ruby
def cap(str)
  str.capitalize!   # does this affect the object outside the method?
end

name = "jim"
cap(name)
puts name
```
Line 2 affect the string object referenced by `name` outside the method. The reason is that when we are calling `cap` method on line 6 and passing in `name` as an argument, the variable `str` local to the scope of the method is initialized to the same string object that `name` is pointing to. When we are calling the mutating method `capitalize!` on `str`, the string object `str` is pointing to is mutated into `"JIM"`. This change also affects the local variable `name` since it is pointing to the same string object.
This example demonstrates the concept of variables as pointers. Specifically that variables in Ruby act as pointers to objects located in the memory. When we are calling a mutating method on an object, it will affect all the variables that are pointing to the object.

```ruby
a = [1, 3]
b = [2]
arr = [a, b]
arr

a[1] = 5
arr
```
`arr` on line 7 is `[[1. 5], [2]]`. The reason is that: On line 1 and 2, local variables `a` and `b` are initialized to arrays `[1, 3]` and `[2]` respectively. On line 3, the local variable `arr` is initialized to a nested array containing two inner arrays that `a` and `b` are pointing to. On line 6, we are using the mutating indexed assignment to change the second element in the array object that `a` references from `3` to `5`, this assignment mutates the array object `a` is pointing to. This mutation also reflects on the array object that `arr` references since it's first element is the same mutated array that `a` references. As a result, `arr` is now `[[1. 5], [2]]`.
This example demonstrates the concept of variables as pointers in Ruby. Specifically that variables in Ruby act as pointers to objects located in the memory. Any mutating actions (method invocation, indexed assignment etc.) on an object will affect all the variables that are referencing this object, or other objects that contain this object.

```ruby
arr1 = ["a", "b", "c"]
arr2 = arr1.dup
arr2.map! do |char|
  char.upcase
end

puts arr1
puts arr2
```
`dup` method creates a shallow copy of the caller, which means only the caller object is copied. If the object contains other objects, they will be shared, not copied.

```ruby
def fix(value)
  value.upcase!
  value.concat('!')
  value
end

s = 'hello'
t = fix(s)
```
Both `s` and `t` have the same value `"HELLO!"`.
On line 7, the local variable `s` is initialized to the string `"hello"`. On line 8, we are calling `fix` method and passing in `s` as an argument. Upon the method invocation, variable `value` local to the scope of the method is initialized to the same string `"hello"` that `s` is referencing. On line 2, we are calling the mutating method `upcase!` on `value`, which resulting the string object that `value` references changed to `"HELLO"`. On line 3, we are calling another mutating method `concat` on `value` and passing in string `"!"` as an argument, resulting in the string object that `value` references being changed to `"HELLO!"`. Since `s` is pointing to the same string object, now `s` has the value of `"HELLO!"` as well.
Finally the local variable `t` is initialized to the return value of `fix` method invocation, which is `"HELLO"!` as well.
This example demonstrates the concept of mutating methods. Specifically that methods that mutate the caller object will also affect all the variables that are referencing this object.

```ruby
def fix(value)
  value = value.upcase
  value.concat('!')
end

s = 'hello'
t = fix(s)
```
`s` has the value of `"hello"`, `t` has the value of `"HELLO!"`.
On line 6, the local variable `s` is initialized to the string `"hello"`. On line 7, we are calling `fix` method and passing in `s` as an argument. Upon the method invocation, variable `value` local to the scope of the method is initialized to the same string object `"hello"` that `s` references. On line 2, `value` is reassigned to the object returned by calling `upcase` method on `value`, which is a new string object `"HELLO"`. On line 3, we are calling the mutating `concat` method on this new string object and passing in the string `"!"`, mutating this object to  `"HELLO!"` and returns `"HELLO!"`. Noted that, at this point, `s` is still pointing to the string object `"hello"`.
Finally, the local variable `t` is initialized to the return value of calling the `fix` method, which is the string object `"HELLO!"`.
THis example demonstrates the concept of variables as pointers. Specifically that variables in Ruby act as pointers to objects in the memory. Reassignment is non-mutating, it merely causes a variable to point to a different object.

```ruby
def fix(value)
  value << 'xyz'
  value = value.upcase
  value.concat('!')
end

s = 'hello'
t = fix(s)
```
`s` has the value `"helloxyz"`, `t` has the value of `"HELLOXYZ!"`.
On line 7, the local variable `s` is initialized to the string `"hello"`. On line 8, we are calling `fix` method and passing in `s` as an argument. Upon the method invocation, variable `value` local to the scope of the method is initialized to the same string object that `s` references. On line 2, we are calling the destructive `String#<<` method on `value` and passing in the string `"xyz"` as an arugment, mutating the string object that `value` references to `"helloxyz"`. On line 3, the local variable `value` is reassigned to the return value of calling `upcase` method on `value`, which is a new string object `"HELLOXYZ"`. At this point, `s` is referencing `"helloxyz"` and `value` is referencing `"HELLOXYZ"`. On line 4, we are calling the destructive method `concat` on `value` and passing in string `"!"`, mutating the caller to `"HELLOXYZ!"` and returning the same object.
Finally, the local variable `t` is initialized to the return object of calling `fix` method, which is `"HELLOXYZ!"`.
This example demonstrates the concept of variables as pointers. Specifically that variables in Ruby act as pointers to objects in the memory. Calling mutating methods on an object will also affect all the variables that reference it. Reassignment is non-mutating, it merely causes a variable to point to a different object.

```ruby
def fix(value)
  value = value.upcase!
  value.concat('!')
end

s = 'hello'
t = fix(s)
```
`s` and `t` both have the value of `"HELLO!"`.
On line 6, the local variable `s` is initialized to the string `"hello"`. On line 7, we are calling `fix` method and passing in `s` as an argument. Upon method invocation, variable `value` local to the scope of the method is initialized to the same string object that `s` references. On line 2, we are calling the destructive `String#upcase!` method on `value`, mutating the string object into `"HELLO"`, then reassigning `value` to the same string object. On line 3, we are calling the destructive `concat` method on `value` and passing in the string `"!"` to it, mutating the string object that `value` references to `"HELLO!"`, and returning the same string object. At this point, both `s` and `value` are pointing to the same string object `"HELLO!"`.
Finally, on line 7, the local variable `t` is initialized to the return value of calling the `fix` method, which is `"HELLO!"` as well.
This example demonstrates the concept of variables and pointers, as well as mutating methods. Specifically that variables in Ruby act as pointers to objects located in the memory. When we are calling mutating methods on the calling object, all variables pointing to this object are also affected.

```ruby
def fix(value)
 value[1] = 'x'
 value
end

s = 'abc'
t = fix(s)
```
Both `s` and `t` have the value of `"axc"`.
On line 6, the local variable `s` is initialized to the string `"abc"`. On line 7, we are calling the `fix` method, passing in `s` as an argument. Upon the method invocation, variable `value` local to the scope of the method is initialized to the same string object that `s` references. On line 2, we are using the mutating indexed assignment to change the second character of the string object `"abc"` that `value` references to `"axc"`. The method returns `"axc"` since the last statement of the method definition evaluates to the value of the local variable `value`.
Finally, on line 7, the local variable `t` is initialized to the return value of calling the `fix` method, which is the string object `"axc"`.
This example demonstrates the concept of mutating method in Ruby. Specifically that indexed assignment is a mutating method.

```ruby
def a_method(string)
  string << ' world'
end

a = 'hello'
a_method(a)

p a
```
On line 5, the local variable `a` is initialized to the string `"hello"`. On line 6, we are calling `a_method` method and passing in `a` as an argument. Upon the method invocation, variable `string` local to the scope of the method is initialized to the same string object that `a` references. On line 2, we are calling the destructive `String#<<` method on `string` and passing in the string object `" world"` as an arugment, mutating the caller to `"hello world"`. This change also affects the local variable `a`.
As a result, on line 8, when we are calling `p` method and passing in `a` as an argument, it's value `"hello world"` would be the output, and the return value is `nil`.
This example demonstrates the concept of mutating method in Ruby. Specifically that methods like `String#<<` mutate its caller, and this will  also affect all the variables that are referencing the caller.

```ruby
num = 3

num = 2 * num
```
On line 1, the local variable `num` is initialized to the integer `3`. On line 3, `num` is reassigned to the return value of calling `*` method on integer `2` and passing in `num` as an argument, which is the integer `6`.

```ruby
def add_name(arr, name)
  arr = arr + [name]
end

names = ['bob', 'kim']
add_name(names, 'jim')
puts names
```
This code outputs `"bob"` and `"kim"`, returns `nil`.
On line 5, the local variable `name` is initialized to an array with two string elements. On line 6, we are calling `add_name` method and passing in `names` and string `"jim"` as arguments. Upon the method invocation, local variable `arr` is initialized to the same array object that `names` references, and local variable `name` is initialized to the string object `"jim"`. On line 2, `arr` is reassigned to a new array object returned by calling `+` method on `arr` with an array object `[name]` passed in as an argument. Since `+` is a non-mutating method and `arr` is now pointing to a new array, `names` and the original array referenced by it is unchanged.
As a result, when we are calling `puts` method and passing in `names` as an argument, it's elements `"bob"` and `"kim"` are printed out.
This example demonstrates the concept of non-mutating methods in Ruby. Specifically that a non-mutating method returns a new object and won't mutate it's caller.

```ruby
[1, 2, 3].select do |num|
  num > 5
  'hi'
end
```
`select` method performs selection based on the truthiness of the return value of the block. In this case, the return value of the block is always `"hi"`, which is a truthy value. As a result, all the elements in the caller will be selected and returned in a new array.

```ruby
[1, 2, 3].reject do |num|
  puts num
end
```
The return value of the `reject` method is `[1, 2, 3]`. `reject` method picks the element when the return value of the block evaluates as `false`. In this case, the return value of the block will always be the return value of calling the `puts` method, which is `nil`. `nil` in Ruby evaluates as `false`. Therefore, each element of the caller is picked and returned in a new array object `[1, 2, 3]`.

```ruby
['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end
```
The return value is a hash object `{'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}`.
`each_with_object` method iterates through each element of the caller and returns the object that passed in as the argument. In this case, the return value would be the hash object that the local variable `hash` references. During each iteration, an indexed assignment is performed where the key is the first character of the current element, and the value is the current element. Therefore, after all the iterations are finished, the hash object referenced by `hash` is returned, which is  `{'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}`.

```ruby
hash = { a: 'ant', b: 'bear' }
hash.shift
```
`shift` method permanently removes the first element of the collection, and returns a two element array. In this case, when we are calling the `shift` method on the local variable `hash`, the first element of the hash object that `hash` is referencing is permanently removed from the hash object, returning the removed element in a `[key, value]` array: `[:a, 'ant']`.

```ruby
['ant', 'bear', 'caterpillar'].pop.size
```
This code returns `11`. This is a chaining method. First, destructive `pop` method is called on the array, removing the last element of the array and returning the element, which is the string object `"caterpillar"`. Then, the `size` method is called on this string object, returning the length of the string, which in this case is `11`.

```ruby
[1, 2, 3].any? do |num|
  puts num
  num.odd?
end
```
What is the block's return value in the following code? How is it determined? Also, what is the return value of any? in this code and what does it output?

The block's return value is determined by the last evaluated statement of the block, which is `num.odd?`. In this case, the return value of the block is `true` if current element is an odd number, and `false` if current element is an even number. The `any?` method returns `true` the first time the return value of the block evaluates as `true`, and the iteration stops here. If all the iterations are done and none of the return values of the block evaluate as `true`, `false` is returned.

In this code, the output is `1` and the return value is `true`.

```ruby
{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end
```
What is the return value of map in the following code? Why?

The return value is an array `[nil, 'bear']`. `map` method takes the return value of the block after each iteration and returns a new array that contains them. In this case, in the first iteration, the block returns `nil` since `value.size > 3` evaluates as `false` and the `if` statement returns `nil`; In the second iteration, `value.size > 3` evaluates as `true`, The block returns `value` which is the string object `"bear"`. As a result, a new array `[nil, 'bear']` is returned by `map` method.

```ruby
[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end
```
What is the return value of the following code? Why?

The return value of the code is an array `[1, nil, nil]`. the `map` method returns a new array based on the return value of the block. Each time the block is executed, if the `if` condition `num > 1` evaluates as `true`, the return value of the `puts` method, which is `nil` is returned. if `num > 1` evaluates as `false`, the local variable `num` is returned. In this case, other than `1`, `nil` is returned each time the block is executed. Therefore, the return value of `map` method is `[1, nil, nil]`.

```ruby
array = [1, 2, 3, 4, 5]

array.select do |num|
   puts num if num.odd?
end
```
This code outputs `1`, `3` and `5`, returns `[]`.
On line 1, the local variable `array` is initialized to an array object `[1, 2, 3, 4, 5]`. `select` method performs selection if the return value of the block evaluates as `true`. In this case, when the `if` condition evaluates as `true`, current element of the collection is printed out and returns `nil`; When the `if` condition evaluates as `false`, the `if` statement returns `nil`. Therefore, `1`, `3` and `5` are outputed while `nil` is returned by the block in each iteration.

As a result, nothing is selected by calling the `select` method on the local variable `array`.

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

arr.select { |n| n.odd? }
```
This code returns `[1, 3, 5, 7, 9]`.
On line 1, the local variable `arr` is initialized to an array object with elements from integer `1` to `10`. `select` method performs selection if the return value of the block evaluates as `true`. In this case, whenever the current element is an odd number, the block returns `true`. Therefore, when we are calling `select` method on `arr` and passing in a block as an argument, all the odd numbers in the collection are selected and returned as a new array object.

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

new_array = arr.select do |n|
  n + 1
end
p new_array
```
This code outputs and returns `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`.
On line 1, the local variable `arr` is initialized to an array object. On line 3, the local variable `new_array` is initialized to the return value of the `select` method invocation on `arr`. `select` method performs selection if the block passed to it evaluates as `true`. In this case, the last evaluated statement within the block is `n + 1`, which always returns a truthy value. Therefore, all the elements in the array object that `arr` is referencing are selected and returned in the form of a new array object, which is `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`.
As a result, when we are calling `p` method and passing in `new_array` as an argument, `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]` will be the output and the return value.
This example demonstrates the concept of using `select` method to iterate through collections in Ruby. Specifically that `select` method performs selection if the block passed to it evaluates as `true`, and returns a new array object.

```ruby
words = %w(jump trip laugh run talk)

new_array = words.map do |word|
  word.start_with?("t")
end

p new_array
```
This code outputs and returns `[false, true, false, false, true]`.
On line 1, the local variable `words` is initialized to an array object. On line 3, the local variable `new_array` is initialized to the return value of calling the `map` method on `words` and passing in a block as an argument. The `map` method returns a new array which contains elements based on the return value of the block. During each iteration, the element of the array that `words` references is passed into the block and assigned to the block parameter `word`. Then we are calling `start_with?` method on the variable `word` and passing in string `"t"` as an argument. The block returns `true` if the value of the variable `word` starts with the letter `t`, and returns `false` if otherwise. As a result, after all the iterations are done, the `map` method returns a new array and the local variable `new_array` is assigned to it, which is `[false, true, false, false, true]`.
When we are calling `p` method and passing in `new_array` as an argument, the output and return value are both `[false, true, false, false, true]`.

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

arr.each { |n| puts n }
```
The code outputs numbers from `1` to `10`, and returns an array `[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`
On line 1, the local variable `arr` is initialized to an array object. On line 3, we are calling `each` method on `arr` and passing in a block as an argument. Each element of the array referenced by `arr` is passed into the block and assigned to the block parameter `n`. Within the block we are calling `puts` method and passing the variable `n` to it, printing out the element and retuning `nil`. Therefore, after all the iterations are done, each element of the array referenced by `arr` is printed out. Since `each` method always returns its caller, the original array that `arr` is referencing would be the return value.



