require 'yaml'
require 'pry'

ARR = [62,55,98,93,48,28,82,78,19,96,31,42,76,25,34,4,18,80,66,6,14,17,57,54,90,27,40,47,9,36,97,56,87,61,91,1,64,71,99,38,70,5,94,85,49,59,69,26,21,60,0,79,2,95,11,84,20,24,8,51,46,44,88,22,16,53,7,32,89,67,15,86,41,92,10,77,68,63,43,75,33,30,81,37,83,3,39,65,12,45,23,73,72,29,52,58,35,50,13,74]

raw_board = YAML.load_file('day_4.yml')

def format_board(arr)
  formatted_board = []
  arr.each do |table|
    table_formatted = table.split(" ")
    new_table = {}
    5.times do |line|
      new_line = []
      5.times do |n|
        new_line << table_formatted[5 * line + n].to_i
      end
      new_table[new_line] = [0, 0, 0, 0, 0]
    end
    formatted_board << new_table
  end
  formatted_board
end

def mark_num(num, board)
  board.each do |brd|
    brd.each do |line, value|
      line.each_with_index do |n, idx|
        if n == num
          value[idx] = 1
        end
      end
    end
  end
end

# def bingo_row(board)
#   indexes = []
#   board.each_with_index do |brd, index|
#     values = brd.values.flatten
#     5.times do |n|
#       if values[n * 5] + values[n * 5 + 1] + values[n * 5 + 2] + values[n * 5 + 3] + values[n * 5 + 4] == 5
#         indexes << index
#         break
#         # return brd
#       end
#     end
#   end
#   indexes
# end

# def check_brd(brd)
#   brd.each do |line, value|
#     if value == [1, 1, 1, 1, 1]
#       return brd
#     end
#   end

#   values = brd.values.flatten
#   5.times do |n|
#     if values[n] + values[n + 5] + values[n + 10] + values[n + 15] + values[n + 20] == 5
#       return brd
#     end
#   end
#   nil
# end

# def bingo_col(board)
#   indexes = []
#   board.each_with_index do |brd, index|
#     values = brd.values.flatten
#     5.times do |n|
#       if values[n] + values[n + 5] + values[n + 10] + values[n + 15] + values[n + 20] == 5
#         indexes << index
#         break
#       end
#     end
#   end
#   indexes
# end

def calculate_score(brd)
  sum = 0
  brd.each do |key, value|
    5.times do |n|
      sum += key[n] if value[n] == 0
    end
  end
  sum
end

def not_bingo(board)
  brd_return = {}
  board.each do |brd|
    values = brd.values.flatten
    if bingo?(values) == false
      return brd
    else
      next
    end
  end
  nil
end

def bingo?(values)
  5.times do |n|
    return true if values[n] + values[n + 5] + values[n + 10] + values[n + 15] + values[n + 20] == 5
    return true if values[n * 5] + values[n * 5 + 1] + values[n * 5 + 2] + values[n * 5 + 3] + values[n * 5 + 4] == 5
  end
  false
end

# def non_winning_count(board, count)
#   board.each do |brd|
#     count += 1 if check_brd(brd)
#   end
#   count
# end

splitted_board = raw_board.split(/\n/)
all_boards = format_board(splitted_board)
brd ={}
number = 0
ARR.each do |num|
  # p num
  # p all_boards
  number = num
  mark_num(num, all_boards)
  # debug_arr = []
  # debug_arr_2 = []
  # debug_arr_3 = []
  # debug_arr << all_boards.count
  # indexes = bingo_row(all_boards)
  # indexes.each do |index|
  #   brd = all_boards.delete_at(index)
  #   # binding.pry if brd && brd.key?([6, 73, 93, 67, 18])
  # end
  # debug_arr << all_boards.count
  # debug_arr_2 << indexes.count
  # debug_arr_3 << indexes

  # break if all_boards.empty?

  # indexes = bingo_col(all_boards)
  # indexes.each do |index|
  #   brd = all_boards.delete_at(index)
  #   # binding.pry if brd && brd.key?([6, 73, 93, 67, 18])
  # end
  # debug_arr << all_boards.count
  # debug_arr_2 << indexes.count
  # debug_arr_3 << indexes
  # puts "#{debug_arr} #{debug_arr_2} #{debug_arr_3}"
  # break if all_boards.empty?


  if not_bingo(all_boards) == nil
    break
  else
    brd = not_bingo(all_boards)
  end

end

p brd
p number
p (calculate_score(brd)) * number
