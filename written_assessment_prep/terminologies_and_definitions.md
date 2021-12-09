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
On `line 1`, we are initializing the local variable `str` and assigning it to a string object with value "hello".
On `line 3`, we are calling `loop` method and passing in `do...end` block as an argument.
On `line 4`, we are reassigning local variable `str` to a new string object with value "world".
On `line 5`, keyword `break` is used to break out of the loop.
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
The code outputs `4` and throws an error: undefined local variable or method `b`.

On `line 1`, we are initializing a local variable `a` and assigning it to an integer `4`.
On `line 3`, we are calling `loop` method and passing `do...end` block to it as an argument.
Inside the block, on `line 4`, we are reassigning the local variable `a` to a different integer `5`.
On `line 5`, we are initializing a local variable `b` and assigning it to an integer `3`.
On `line 6`, `break` keyword is used to break out of the loop.
On `line 9`, we are calling `puts` method and passing in the local variable `a` as an argument. It prints out `4` which is the value of the object where variable `a` is pointing to, and returns `nil`.
On `line 10`, `puts` method is called again and trying to pass in the local variable `b` as an argument. However, the local variable `b` is defined inside the block, and local variables that are initialized in an inner scope can not accessed in the outside scope. As a result, an exception will be raised because Ruby can not find a local variable or method called `b`.

## Variable Shadowing
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
On `line 1` we are initializing the local variable `a` and assigning it to an integer object with value `4`.
On `line 2` we are initializing the local variable `b` and assigning it to an integer object with value `2`.
On `line 4` we are calling the method `times` on the integer object with the value `2` and passing `do...end` block to it as an argument with one parameter `a`
On `line 5` the local variable `a` that is initialized inside the scope of the block is reassigned to an integer object with the value `5`. Noted that because of variable shadowing, the local variable `a` that initialized in inner scope is not the same as the local variable with the same name initialized in outer scope.
On `line 6` we are calling `puts` method on the local variable `a` in inner scope and passing the local variable `a` as an argument. So the code on `line 4-7` outputs `5` and `5`.

## Mutating vs Non-mutating Methods / Pass By Reference vs Pass By Value / Variables As Pointers
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

## Different types of variables

# Methods
- puts vs return
- method definition and method invocation
- implicit return value of method invocations and blocks

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
On `line 1-8` the method `example` is defined which takes one parameter. On `line 10` the method is called and a string `hello` is passed in as an argument.
On `line 2` local variable `i` is initiated and assigned an integer object with value `3`. On `line 3` we are calling the `loop` method and passing in `do...end` block as an argument. On `line 4`, we are calling `puts` method and passing in the local variable `str` to it as an argument. On `line 5`, the local variable `i` is reassigned to the return value of the method call `Integer#-` on a local variable `i` and with the integer `1` passed to it as an argument. On `line 6`, the keyword `break` is used to break out of the loop when the the value of the object that local variable `i` is referencing equals to 0.
This code outputs string `hello` 3 times and returns `nil`.

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
- working with collections (Array, Hash, String), and popular collection methods (each, map, select, etc). Review the two lessons on these topics thoroughly.

Array: elememts are retrievable by index
Mostly we use symbol as the key in a hash, why?
Symble vs String: symbles are immutable strings.

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

# Sorting