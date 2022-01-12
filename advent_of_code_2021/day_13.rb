require 'yaml'
require 'pry'

# INSTRUCTION = { x: [655, 327, 163, 81, 40], y: []

raw_data = YAML.load_file('day_13.yml').split.map { |cor| cor.split(",") }
DOTS = raw_data.map { |cor| cor.map { |str| str.to_i } }
X_MAX = DOTS.map { |dot| dot[0] }.max
Y_MAX = DOTS.map { |dot| dot[1] }.max

def initialize_paper!(paper)
  0.upto(Y_MAX) do |y|
    line = []
    0.upto(X_MAX) do |x|
      line[x] = 0
    end
    paper << line
  end
end

def add_dots!(paper)
  DOTS.each do |dot|
    paper[dot[1]][dot[0]] = 1
  end
end

def fold_up(small, large, difference)
  small.each_with_index do |line, index|
    line.each_with_index do |num, idx|
      large[index + difference][idx] += num
      # binding.pry
    end
  end
  large
end

def fold_y(paper, y)

  piece = paper.slice!(y, paper.count - y)
  piece.shift
  piece.reverse!
  difference = paper.count - piece.count
  if difference >= 0
    fold_up(piece, paper, difference)
  else
    fold_up(paper, piece, 0 - difference)
  end
end

def fold_left(small, large, difference)
  small.each_with_index do |num, index|
    large[index + difference] += num
  end
  large
end

def fold_x(paper, x)
  paper.map do |line|
    piece = line.slice!(x, line.count - x)
    piece.shift
    piece.reverse!
    difference = line.count - piece.count
    if difference >= 0
      fold_left(piece, line, difference)
    else
      fold_left(line, piece, 0 - difference)
    end
  end
end

def count(paper)
  count = 0
  paper.flatten.each do |num|
    count += 1 if num > 0
  end
  count
end

paper = []
initialize_paper!(paper)
add_dots!(paper)
# paper = fold_y(paper, 7)
# p paper
# paper = fold_x(paper, 5)
paper = fold_x(paper, 655)
paper = fold_y(paper, 447)
paper = fold_x(paper, 327)
paper = fold_y(paper, 223)
paper = fold_x(paper, 163)
paper = fold_y(paper, 111)
paper = fold_x(paper, 81)
paper = fold_y(paper, 55)
paper = fold_x(paper, 40)
paper = fold_y(paper, 27)
paper = fold_y(paper, 13)
paper = fold_y(paper, 6)
paper.each_with_index do |line, y|
  line.each_with_index do |num, x|
    if num > 0
      paper[y][x] = 'X'
    else
      paper[y][x] = 111
    end
  end
  p line
end




=begin
P
- find out the number of dots on the sheet after the 1st fold
- rules:
  - dots will never appear on a fold line
  - `y` means fold up, `x` means fold left
  - after a fold, over-lapped dots becomes one dot

D
- inpit: array, instruction
- output: integer
- an array 'paper' to store dots info

A
- if folding up:
  - slice! the paper from index `y` until the end, store the slice into a `piece`
  - reverse the `piece`
  - disgard the last element of `paper`
  - difference = paper.count - piece.count
  - if difference >= 0
    - iterate through `piece`, for each line with index
      - get the `line` from `paper`[index + difference]
      - iterate through the line, for each num with idx
        - add the num to `line`[idx]
    - return `piece`
  - if difference < 0
    - iterate through `paper`, for each line with index
      - get the `line` from `piece`[index - difference]
      - iterate through the line, for each num with idx
        - add the num to `line`[idx]
    - return `paper`
  - add a [0,0,0s] to the last of whatever returns

if folding left:
  - iterate through `paper`, for each line
    - slice! the line from index `x` until the end, store the slince into `piece`
    - reverse the `piece`
    - disgard the last element of `line`
    - difference = line.count - piece.count
    - if difference >= 0
      - fold_left(piece, paper, difference)
    - else
      - fold_left(paper, piece, 0 - difference)
  - add a 0 to the last element of whatever returns

iterate through paper,
  - if element > 0 ,counter += 1
  - set anything > 1 to 1

output counter
=end