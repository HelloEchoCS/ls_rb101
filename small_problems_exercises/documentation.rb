=begin

1

File::path
Returns the string representation of the path

File#path
Returns the pathname used to create file as a string. Does not normalize the name.
The pathname may not point to the file corresponding to file. For instance, the pathname becomes void when the file has been moved or deleted.
This method raises IOError for a file created using File::Constants::TMPFILE because they don't have a pathname.

File::path only works on the "File" class itself -- this is a class method
File#path works on any object under File category -- this is an instance method

2

require 'date'

puts Date.civil => "-4172-01-01"
puts Date.civil(2016) =>"2016-01-01"
puts Date.civil(2016, 5) =>"2016-05-01"
puts Date.civil(2016, 5, 13) =>"2016-05-13"

3

=> [4, 5, 3, 6]

4

a = [1, 4, 8, 11, 15, 19]
value = a.bsearch { |x| x > 8 }

5

a = %w(a b c d e)
puts a.fetch(7) =>IndexError
puts a.fetch(7, 'beats me') => 'beats me'
puts a.fetch(7) { |index| index**2 } => 49

6

=>
5
8

7

puts s.public_methods(false).inspect

8

a = [5, 9, 3, 11]
puts a.min(2)

9



=end