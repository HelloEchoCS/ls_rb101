require 'yaml'
require 'io/console'

CONFIG = YAML.load_file('21_config.yml')
CARDS_AND_VALUES = CONFIG['cards_and_values']
SETTINGS = CONFIG['menu']['settings']
RULES = <<-MSG
  Rules of Play

  The object of the game is to create card totals higher than those of the
  dealer's hand but not exceeding 21, or by stopping at a total in the hope
  that dealer will bust. On their turn, players choose to "hit" (take a card)
  or "stay" (end their turn and stop without taking a card).

  Number cards count as their number, the jack, queen, and king count as 10,
  and aces count as either 1 or 11. If the total exceeds 21 points, it busts,
  causing immediately lose.
MSG
SUITES = %w(S H D C)
SUITE_SYMBOLS = {
  'S' => '♠',
  'D' => '♦',
  'C' => '♣',
  'H' => '♥'
}

def prompt(str)
  puts ">>> #{str}"
end

def initialize_deck
  SUITES.product(CARDS_AND_VALUES.keys).shuffle
end

def initialize_hands
  { player: [], dealer: [] }
end

def initialize_score
  { player: 0, dealer: 0 }
end

def deal_initial_cards!(deck, hand)
  hand[:player][0] = deck[0]
  hand[:player][1] = deck[1]
  hand[:dealer][0] = deck[2]
  hand[:dealer][1] = deck[3]
  deck.shift(4)
end

def draw_a_card!(hand, deck)
  deck.shuffle
  hand << deck[0]
  deck.shift
end

def display_game_board(hands, player_value, show_hand=false)
  system 'clear'
  puts "Dealer's hand"
  display_hand(hands[:dealer], show_hand)
  puts ""
  puts ""
  puts ""
  puts "Your hand"
  display_hand(hands[:player], true)
  puts ""
  puts "Your value: #{player_value}"
  puts ""
end

def display_hand(hand, show_hands=true)
  card_num = hand.count
  top_line = ""
  if show_hands
    hand.each { |card| top_line << format_card_number(card) } if show_hands
  else
    top_line = format_card_number(hand.first) + "|    | " * (card_num - 1)
  end
  puts "+----+ " * card_num
  puts top_line
  puts "|    | " * card_num
  puts "+----+ " * card_num
end

def format_card_number(card)
  symbol = SUITE_SYMBOLS[card[0]]
  number = card[1]
  return "|#{symbol}10 | " if number == "10"
  "|#{symbol}#{number}  | "
end

# Menu display & interactions

def main_menu
  valid_options = get_valid_options(CONFIG['menu']['main_menu'])
  loop do
    display_main_menu
    loop do
      answer = gets.chomp
      next if valid_input?(answer, valid_options) == false
      return nil if answer == '1'
      show_rules if answer == '2'
      settings if answer == '3'
      exit! if answer == '4'
      break
    end
  end
end

def display_main_menu
  system 'clear'
  puts "Welcome to Twenty-One!"
  puts ""
  CONFIG['menu']['main_menu'].each do |_, para|
    puts "[#{para['item_num']}] #{para['name']}"
  end
  puts ""
  prompt "Please choose one of the options:"
end

def show_rules
  system 'clear'
  puts RULES
  puts ""
  prompt "Press any key to return to the main menu"
  STDIN.getch
end

def display_settings
  system 'clear'
  puts "Settings"
  puts ""
  SETTINGS.each do |_, para|
    if para['name'] == 'Main Menu'
      puts "[#{para['item_num']}] #{para['name']}"
    else
      puts "[#{para['item_num']}] #{para['name']} (Current: #{para['value']})"
    end
  end
  puts ""
  prompt "Please choose one of the options:"
end

def valid_input?(input, valid_options)
  if valid_options.include?(input)
    true
  else
    puts "Invalid option. Please choose again."
    false
  end
end

def get_valid_options(hsh)
  hsh.values.map do |item|
    item['item_num']
  end
end

def settings
  valid_options = get_valid_options(SETTINGS)
  loop do
    display_settings
    loop do
      answer = gets.chomp
      next if valid_input?(answer, valid_options) == false
      case answer
      when '1' then set_max_totals
      when '2' then set_stay_threshold
      when '3' then set_score_to_win
      when '4' then return nil
      end
      break
    end
  end
end

def set_score_to_win
  prompt "Please enter the score in order to win the game:"
  loop do
    answer = gets.chomp
    if answer.to_i.to_s == answer
      SETTINGS['score_to_win']['value'] = answer.to_i
      File.open('21_config.yml', 'w') { |f| f.write(CONFIG.to_yaml) }
      break
    else
      prompt "Invalid input. Please enter again."
    end
  end
end

def set_max_totals
  prompt "Please enter the maximum card totals:"
  loop do
    answer = gets.chomp
    if answer.to_i.to_s == answer
      SETTINGS['max_totals']['value'] = answer.to_i
      File.open('21_config.yml', 'w') { |f| f.write(CONFIG.to_yaml) }
      break
    else
      prompt "Invalid input. Please enter again."
    end
  end
end

def set_stay_threshold
  prompt "Please enter Dealer's 'Stay' threshold:"
  loop do
    answer = gets.chomp
    if answer.to_i.to_s == answer
      SETTINGS['stay_threshold']['value'] = answer.to_i
      File.open('21_config.yml', 'w') { |f| f.write(CONFIG.to_yaml) }
      break
    else
      prompt "Invalid input. Please enter again."
    end
  end
end

# Game mechanics & algorithms

def count_aces(hand)
  count = 0
  hand.each do |card|
    count += 1 if card[1] == 'A'
  end
  count
end

def calculate_value(hand)
  ace_count = count_aces(hand)
  value = 0
  hand.each do |card|
    value += CARDS_AND_VALUES[card[1]]
  end
  ace_count.times do |_|
    value += 10
    return value - 10 if busted?(value)
  end
  value
end

def busted?(value)
  value > SETTINGS['max_totals']['value']
end

def player_turn(hands, player_value, deck)
  loop do
    prompt "[H]it or [S]tay?"
    answer = gets.chomp.downcase
    if answer == 'h'
      draw_a_card!(hands[:player], deck)
      player_value = calculate_value(hands[:player])
      display_game_board(hands, player_value)
      break if busted?(player_value)
    elsif answer == 's'
      break
    else prompt "Invalid input. Please enter again."
    end
  end
  player_value
end

def dealer_turn(hands, player_value, dealer_value, deck)
  loop do
    break if busted?(player_value)
    if dealer_value < SETTINGS['stay_threshold']['value']
      draw_a_card!(hands[:dealer], deck)
      dealer_value = calculate_value(hands[:dealer])
      display_game_board(hands, player_value)
    else
      break
    end
  end
  dealer_value
end

def decide_winner(player_value, dealer_value)
  return 'Player' if busted?(dealer_value)
  return 'Dealer' if busted?(player_value)
  return 'Player' if player_value > dealer_value
  return 'Dealer' if dealer_value > player_value
  'Draw' if player_value == dealer_value
end

def update_score(winner, score)
  score[:player] += 1 if winner == 'Player'
  score[:dealer] += 1 if winner == 'Dealer'
  score
end

def dispaly_round_result(winner, score)
  puts "You win!" if winner == 'Player'
  puts "Dealer wins!" if winner == 'Dealer'
  puts "It's a draw!" if winner == 'Draw'
  puts ""
  puts "Your score: #{score[:player]}, Dealer score: #{score[:dealer]}"
  puts ""
end

def grand_winner?(score)
  score_to_win = SETTINGS['score_to_win']['value']
  score[:player] == score_to_win || score[:dealer] == score_to_win
end

def display_final_result(score)
  score_to_win = SETTINGS['score_to_win']['value']
  if score[:player] == score_to_win
    puts "The Grand Winner Is The Player!"
  else
    puts "The Grand Winner Is The Dealer!"
  end
end

def another_round?
  loop do
    prompt "Play next round? (Y/N)"
    answer = gets.chomp.downcase
    case answer
    when 'y' then return true
    when 'n' then return false
    else prompt "Invalid input. Please enter Y for yes, N for No."
    end
  end
end

def new_game?
  loop do
    prompt "Do you want to start a new game? (Y/N)"
    answer = gets.chomp.downcase
    case answer
    when 'y' then return true
    when 'n' then return false
    else prompt "Invalid input. Please enter Y for yes, N for No."
    end
  end
end

# Program Body

main_menu
loop do
  score = initialize_score
  loop do
    deck = initialize_deck
    hands = initialize_hands
    deal_initial_cards!(deck, hands)
    player_value = calculate_value(hands[:player])
    dealer_value = calculate_value(hands[:dealer])
    display_game_board(hands, player_value)

    player_value = player_turn(hands, player_value, deck)
    dealer_value = dealer_turn(hands, player_value, dealer_value, deck)

    winner = decide_winner(player_value, dealer_value)
    score = update_score(winner, score)
    display_game_board(hands, player_value, true)
    dispaly_round_result(winner, score)

    if grand_winner?(score)
      display_final_result(score)
      break
    end

    break unless another_round?
  end
  break unless new_game?
end

prompt "Thank you for playing. Have a great day!"
