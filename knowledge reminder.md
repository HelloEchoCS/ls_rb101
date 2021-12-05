# RB101

- `? :` is the ternary operator for if...else
- `!!<some object>` is used to turn any object into their boolean equivalent.
- `String#gsub` method
- `Hash#assoc` method: look for the given key and return an array with the key-value pair. nil if key was not found.
- `Hash#include?`: look for the given key and return true or false
- `String#swapcase!`
- `String#center`
- String * Integer can return a new string with multiple original string concatenated together
- when you initialize a local variable within an `if` block, even if that `if` block doesn’t get executed, the local variable is initialized to `nil`.
- `String#each` & `String#map` difference
- Array#reduce
- `any?` stops iterating after this point since there is no need to evaluate the remaining items in the array;
- Array/Hash#keep_if vs select!
- Hash#key vs Hash#keys
- `map` method only returns AN ARRAY, not hash!!!!!