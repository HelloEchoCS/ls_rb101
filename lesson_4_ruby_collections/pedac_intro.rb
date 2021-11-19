# PROBLEM:

# Given a string, write a method `palindrome_substrings` which returns
# all the substrings from a given string which are palindromes. Consider
# palindrome words case sensitive.

# Test cases:

# palindrome_substrings("supercalifragilisticexpialidocious") == ["ili"]
# palindrome_substrings("abcddcbA") == ["bcddcb", "cddc", "dd"]
# palindrome_substrings("palindrome") == []
# palindrome_substrings("") == []

# Understand the problem.

# Questions to ask:
# 1. Can a string contains spaces/numbers/symbols? If yes, can a palindrome contains these elements?
# 2. Will inputs always be strings?  <<<<<<<<<<< VERY IMPORTANT!!!

# input: string
# output: an array of substrings
# rules:
#   Explicit requirements:
#     - return all the substrings which are palindromes
#     - palindrome words are case sensitive
#   Implicit requirements:
#     - output an empty array when no palindrome were found
#     - output an empty array when given an empty string
#     - palindromes can overlap with each other