require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = []
TOTAL_WINS = 5

PLAYERS = { 1=> 'Player', 2=> 'Computer' }
PROMPT_HISTORY = []
BOARD_SIZE = 3

def clear_screen
  system 'clear'
end

def generate_basic_winning_lines(size)
  [[1, 2, 3], [1 + size, 2 + size, 3 + size], [1 + 2 * size, 2 + 2 * size, 3 + 2 * size],
  [1, 1 + size, 1 + 2 * size], [2, 2 + size, 2 + 2 * size], [3, 3 + size, 3 + 2 * size],
  [1, 2 + size, 3 + 2 * size], [3, 2 + size, 1 + 2 * size]]
end

def generate_winning_lines(size)
  (size - 2).times do |y|
    (size - 2).times do |x|
      generate_basic_winning_lines(size).each do |line|
        WINNING_LINES << line.map { |square| square = square + x + (y * size) }
      end
    end
  end
end

def prompt(str, save=true)
  save_prompt_to_history!("- #{str}") if save
  puts ">>> #{str}"
end

def save_prompt_to_history!(str)
  # binding.pry
  if PROMPT_HISTORY.count < 3
    PROMPT_HISTORY << str
  else
    PROMPT_HISTORY.shift
    PROMPT_HISTORY << str
  end
end

def display_prompt_history
  PROMPT_HISTORY.each { |info| puts info }
end

# don't really like the mutating solution given by the course material.
def joinor(arr, delimiter=', ', last_word='or')
  if arr.count == 1
    arr[0]
  else
    arr[0..(arr.count - 2)].join(delimiter) +
      delimiter + last_word + ' ' + arr.last.to_s
  end
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def display_board(brd, score)
  clear_screen
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}."
  puts "Current score: You - #{score[:player]}, Computer - #{score[:computer]}"
  puts ""
  BOARD_SIZE.times do |line|
    single_line = ""
    top_line = ""
    BOARD_SIZE.times do |n|
      number = n + line * BOARD_SIZE + 1
      if number >= 10
        top_line << "#{number}   |"
      else
        top_line << "#{number}    |"
      end
    end
    puts top_line
    BOARD_SIZE.times do |square_number|
      single_line << "  #{brd[(line * BOARD_SIZE) + square_number + 1]}  |"
    end
    puts single_line
    puts "     |" * BOARD_SIZE
    puts "-----+" * BOARD_SIZE
  end
  puts ""
  puts "Message History:"
  display_prompt_history
  puts ""
end


# def display_board(brd, score)
#   clear_screen
#   puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}."
#   puts "Current score: You - #{score[:player]}, Computer - #{score[:computer]}"
#   puts ""
#   puts "     |     |"
#   puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
#   puts "     |     |"
#   puts "-----+-----+-----"
#   puts "     |     |"
#   puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
#   puts "     |     |"
#   puts "-----+-----+-----"
#   puts "     |     |"
#   puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
#   puts "     |     |"
#   puts ""
#   puts "Message History:"
#   display_prompt_history
#   puts ""
# end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

def initialize_board
  new_board = {}
  (1..(BOARD_SIZE ** 2)).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt("Choose a square (#{joinor(empty_squares(brd))}):", false)
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt("Sorry, that's not a valid choice", false)
  end
  brd[square] = PLAYER_MARKER
end

def scan_threats(brd)
  threats = []
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
       brd.values_at(*line).count(COMPUTER_MARKER) == 0
      threats << line[brd.values_at(*line).index(" ")]
    end
  end
  threats
end

def scan_wincon(brd)
  wincon = []
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(COMPUTER_MARKER) == 2 &&
       brd.values_at(*line).count(PLAYER_MARKER) == 0
      wincon << line[brd.values_at(*line).index(" ")]
    end
  end
  wincon
end

# def ai(brd)
#   return scan_wincon(brd).sample unless scan_wincon(brd).empty?
#   return scan_threats(brd).sample unless scan_threats(brd).empty?
#   return 5 if brd[5] == ' '
#   empty_squares(brd).sample
# end

def copy_board(brd)
  new_brd = {}
  brd.each { |k, v| new_brd[k] = v }
  new_brd
end

def ai_impossible(brd)
  evaluation_results = {}
  depth = empty_squares(brd).count - 1

  empty_squares(brd).each do |square|
    new_brd = copy_board(brd)
    evaluation_results[square] = minimax(square, depth, true, empty_squares(brd), new_brd)
    p evaluation_results
  end

  possible_moves = evaluation_results.select do |_, value|
    value == evaluation_results.values.max
  end
  possible_moves.keys.sample
end

def minimax(square, depth, ai_turn, possible_squares, brd)
  return determine_node_value(brd) if terminal_node?(brd)
  if depth == 0
    put_final_piece(square, ai_turn, brd)
    return determine_node_value(brd) #this is the end
  end
  if ai_turn
    value = 1000
    possible_squares = determine_child_node(square, possible_squares)
    possible_squares.each do |child|
      possible_squares.each { |key| brd[key] = INITIAL_MARKER }
      brd[square] = COMPUTER_MARKER
      value = [value, minimax(child, depth - 1, false, possible_squares, brd)].min
    end
    return value
  else
    value = -1000
    possible_squares = determine_child_node(square, possible_squares)
    possible_squares.each do |child|
      possible_squares.each { |key| brd[key] = INITIAL_MARKER }
      brd[square] = PLAYER_MARKER
      value = [value, minimax(child, depth - 1, true, possible_squares, brd)].max
    end
    return value
  end
end

def put_final_piece(square, ai_turn, brd)
  if ai_turn
    brd[square] = COMPUTER_MARKER
  else
    brd[square] = PLAYER_MARKER
  end
end

def determine_child_node(square, available_squares)
  available_squares.select { |node| node != square }
end

def determine_node_value(brd)
  return -100 if detect_winner(brd) == 'Player'
  return 100 if detect_winner(brd) == 'Computer'
  0
end

def terminal_node?(brd)
  detect_winner(brd)
end

def computer_places_piece!(brd)
  square = ai_impossible(brd)
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def update_scores(brd, score)
  score[:player] += 1 if detect_winner(brd) == 'Player'
  score[:computer] += 1 if detect_winner(brd) == 'Computer'
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return 'Player' if brd.values_at(*line).count(PLAYER_MARKER) == 3
    return 'Computer' if brd.values_at(*line).count(COMPUTER_MARKER) == 3
  end
  nil
end

def grand_winner?(score)
  score[:player] == TOTAL_WINS || score[:computer] == TOTAL_WINS
end

def grand_winner(score)
  return 'Player' if score[:player] == TOTAL_WINS
  return 'Computer' if score[:computer] == TOTAL_WINS
end

def play_the_round(first_player, brd, scores)
  current_player = first_player
  loop do
    display_board(brd, scores)
    play_piece!(brd, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(brd) || board_full?(brd)
  end
end

def play_piece!(brd, current_player)
  if current_player == 'Player'
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def flip_coin
  coin = [1, 2].sample
  if PLAYERS[coin] == 'Player'
    prompt "The coin is in favor of you."
    return 'Player'
  end
  prompt "The coin is in favor of Computer."
  'Computer'
end

def decide_first_player(current_player)
  if current_player == 'Player'
    prompt("Who goes first? (1 - You, 2 - Computer)", false)
    return PLAYERS[gets.chomp.to_i]
  end
  computer_choice = PLAYERS[[1, 2].sample]
  if computer_choice == 'Player'
    prompt "Computer chose you to go first."
  else
    prompt "Computer decided to go first."
  end
  computer_choice
end

def alternate_player(current_player)
  return 'Computer' if current_player == 'Player'
  'Player'
end

# Program body

clear_screen
generate_winning_lines(BOARD_SIZE)
prompt "Welcome to Tic Tac Toe!"
loop do
  scores = { player: 0, computer: 0 }
  decider = flip_coin
  loop do
    board = initialize_board
    binding.pry
    first_player = decide_first_player(decider)
    decider = alternate_player(decider)

    play_the_round(first_player, board, scores)

    update_scores(board, scores)
    display_board(board, scores)

    if someone_won?(board)
      prompt "#{detect_winner(board)} won this round!"
    else
      prompt "It's a tie!"
    end

    if grand_winner?(scores)
      prompt "The Grand Winner is #{grand_winner(scores)}!"
      break
    else
      prompt("Next round? (y or n)", false)
      answer = gets.chomp
      break unless answer.downcase.start_with?('y')
    end
  end

  prompt("Start over again? (y or n)", false)
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe, Goodbye!"
