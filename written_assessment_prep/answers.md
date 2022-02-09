On line 3, we are acutally calling the `Hash#[]` method twice to retrieve the value in the nested hash that `my_hash` is referencing.

First, we are calling the `Hash#[]` method on `my_hash` and passing in the symbol `:b` as an argument. It returns the value of the key-value pair from `my_hash` where the key is `:b`. The return value is a hash object `{d: 3, e: 5}`.

Then, we are calling the `Hash#[]` method again on the returned hash object `{d: 3, e: 5}`, passing in the symbol `:d` as an argument. It returns the value of the key-value pair from the caller where the key is `:d`. The return value is `3`.

This example demonstrates the concept of syntactical sugar in Ruby. Specifically that `my_hash[:b]` is actually the syntactical sugar of calling the method `Hash#[]` on `my_hash`, which can be written as `my_hash.[](:b)`. In addition, we are also chaining the methods by written `my_hash.[](:b).[](:d)` as `my_hash[:b][:d]` using the syntactical sugar.