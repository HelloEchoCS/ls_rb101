# Given a string as input, find all substrings of at least 2 characters where the substring is adjacent to a substring that is the reverse of itself.

p find_reverse_substrings('1221345543') == ["12", "21", "345", "543", "45", "54"]
p find_reverse_substrings('beeekkeeper') == ["eek", "kee", "ek", "ke"]
p find_reverse_substrings('1111111') == ["11", "111"]
p find_reverse_substrings('hellolleh') == []
p find_reverse_substrings('testtsetsubjecttcejbus') == ["test", "tset", "est", "tse", "st", "ts", "subject", "tcejbus", "ubject", "tcejbu", "bject", "tcejb", "ject", "tcej", "ect", "tce", "ct", "tc"]

=begin
P:
- given a string as input, find all adjacent substrings where one substring is the reverse of another
- rules:
  - the output is an array containing all the substrings that are found
  - all substrings are at least 2 chars long
  - substring "pairs" have to be adjacent with each other
  - if none is found, return an empty array
  - a substring's length has to be at most 1/2 of the input string's length

D:
- input: string
- output: array containing strings as its elemnt

A:
- initialize the result array
- starting from the first character of the input: set `start_char` = 0, set `string_length` to input string's length
  - starting from `length` 2, find all possible substrings until the length of the substring equals half of the `string_length`
  - check the substring starting from the character indexed at `start_char` + `length`, see if this substring is the reverse of the current substring
    - if yes
      - put current substring and checked substring into the array
    - add length by 1
    - reduce `string_length` by 1 and go to next iteration if length is greater than `string_length`
  - after all iterations are done, add `start_char` by 1
- break out of the iteration if `length` is greater than the length of the input string


=end


# Given a string as input, find the longest substring that does not have any consecutive repeating characters.

p find_longest_substring('bookkeeper') == "epe"
p find_longest_substring('launch school') == "launch scho"
p find_longest_substring('leetucebox') == "etucebo"
p find_longest_substring('eeeee') == nil