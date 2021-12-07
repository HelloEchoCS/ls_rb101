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

## Syntatical Sugar List
  - TBC

# Local Variable Scope
Variables initialized in the outside scope are accessible in the inner scope (or in the block).
Variables initialized inside block/the inner scope are not accessible in a outer scope.
```ruby
str = "hello" # variable initialization

loop do
  str = "world" # variable re-assignment
  break
end
```

# Pass By Reference vs Pass By Value
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
On line 2, the variable `param` is re-assigned to a new string object returned by the string concatenation method which combine the string assigned to the variable `param` with the string " world".
On line 4, the destructive method is performed on the new string object, which has nothing to do with the string object assigned to the variable `str`.
Therefore on line 10, the p method will output "hello"

# Different types of variables