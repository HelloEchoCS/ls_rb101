
P
- add up all snailfish numbers using specific rules(see below)
- rules:
  - every number is a pair
  - addition is to using two numbers and form a new pair (add a layer)
  - after one addition action, reduce needs to be done. Check if there could be an explode action first,
    if not, then check if there could be a split action.
  - only one action can be applied, after the action, the result needs to be checked with (explode, if not split) again.
  - if no action can be taken, the reduction ends. It's ready for next addition if it applies.
  - explode rules:
    - criteria:  if any pair is nested inside 4 pairs, and consists of two regular numbers. Check from left to right
    - the pair's left value is added to the first regular number to its left,
      the pair's right value is added to the first regular number to its right.
    - if no number can be added, leave it for now
    - after both values are dealt with, change current pair to a `0`
  - split rules:
    - criteria: any regular number is 10 or greater, check from left to right
    - replace the number with a pair, 11 => [5 ,6], 12 => [6, 6]
  - check magnitude:
    - the magnitude of a pair is p[0] * 3 + p[1] * 2, calculation starts from the most inner pairs

D
- input: arrays?
- output: int

A
- iterate through all numbers, for each num
  - `add()` it to `result`
  - loop `explode` or `split` until no action can be taken:
    - check for `explosion`, if any, do `explode` then next
    - check for `split`, if any, do `split` then next
    - break
- use the `result` to calculate magnitude

- add(arr1, arr2)
  - return [arr1, arr2]

- check for `explosion`
  - set level = 1
  - check two elements of the array, if any of them are an array,
    - iterate over two elements with index, for each element
      - if status[:found] = true, return to upper level
      - if it's an Array, add index to `location`, do `check` for this array, level += 1
  - if both of them are Integers
    - if level > 4,
      - set status[:found] = true
    - else, return to upper level

- explode:
  - get target pair using location, get left value & right value, change pair to 0
  - if location.sum == 0, the target pair[0] == 0
  - else
    - find the closest element[1]
    - add left value to element[0]
  - if location.sum == location.count, the target pair[1] == 0
  - else
    - find the closest element[0]
    - loop
      - if element[0] is integer
        - add right value to element[0]
        - break
      - else
        - element = element[0]

- check for `split`
  - map over two elements, for each element
    - if status[:found] = true
      - element
    - if element is integer
      - if element >= 10,
        - set status[:found] = true
        - if element.odd?, element = [element / 2, element / 2 + 1]
        - if element.even?, element = [element / 2, element / 2]
      - else
        - element
    - else
      - `split`()


[[[[4, 0], [5, 0]], [[[4, 5], [2, 6]], [9, 5]]], [7, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]]]

[[[[4, 0], [5, 4]], [[7, 7], [0, [6, 7]]]], [10, [[11, 9], [11, 0]]]]