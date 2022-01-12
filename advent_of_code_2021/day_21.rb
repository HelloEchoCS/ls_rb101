require 'pry'

DICE_VALUES = {3=>1, 4=>3, 5=>6, 6=>7, 7=>6, 8=>3, 9=>1}
=begin
A
- initialize player points and position
- loop with counter `n` starts at 0
  - if `n` is even then it's player 1's turn; if its odd then it's player 2's turn
  - `roll` += 1
  - calculate dice value
  - move pawn and get the score
  - update the score, see if > 1000 pts
    - if yes, break and get the value of `n`, `roll`
    - if not, `n` += 1, then next iteration

- calculate dice value:
  - (n * 3 + 1) + (n * 3 + 2) + (n * 3 + 3)

- move pawn and get score
  - based on dice value
    - convert dice_value to string
    - get the length of the string
      - if length <= 2, `dice_value` % 10
      - else, `dice_value` % 10**(length - 1)
    - position = (previous position + modulo) % 10



=end

# def initialize_scores
#   {player1: 0, player2: 0}
# end

# def initialize_positions
#   {player1: 3, player2: 7}
# end

# def calculate_dice_value(n)
#   length = n.to_s.length
#   if length == 1
#     n = n % 10
#   else
#     n = n % (10 ** (length - 1))
#   end
#   p [length, (n * 3 + 1), (n * 3 + 2), (n * 3 + 3)]
#   (n * 3 + 1) + (n * 3 + 2) + (n * 3 + 3)
# end

# def update_score_and_pos!(dice_value, positions, scores, player)
#   length = dice_value.to_s.length
#   if length <= 2
#     move = dice_value % 10
#   else
#     move = dice_value % (10 ** (length - 1))
#   end
#   # binding.pry
#   position = move + positions[player]
#   if position == 10
#     positions[player] = 10
#   else
#     positions[player] = (positions[player] + move) % 10
#   end
#   scores[player] += positions[player]
# end

# scores = initialize_scores
# positions = initialize_positions
# n = 0
# roll = 0
# loop do
#   player = :player1 if n.even?
#   player = :player2 if n.odd?
#   roll += 3
#   dice_value = calculate_dice_value(n)
#   update_score_and_pos!(dice_value, positions, scores, player)
#   if scores[player] >= 1000
#     break
#   else
#     n = 0 if n == 10
#     n += 1
#     next
#   end
# end

# p scores
# p roll
# p scores.values.min * roll

# def generate_dice_values
#   values = {}
#   1.upto(3) do |a|
#     1.upto(3) do |b|
#       1.upto(3) do |c|
#         sum = a + b + c
#         if values[sum]
#           values[sum] += 1
#         else
#           values[sum] = 1
#         end
#       end
#     end
#   end
#   values
# end

# p generate_dice_values

def generate_possible_outcomes(arr)
  current_pos = arr[0]
  current_score = arr[1]
  positions = DICE_VALUES.keys.map { |key| key + current_pos }
  new_pos = positions.map do |p|
    if p == 10
      p
    else
      p % 10
    end
  end
  outcomes = {}
  new_pos.each_with_index do |pos, index|
    outcomes[[pos, current_score + pos]] = DICE_VALUES.values[index]
  end
  outcomes
end

def get_combinations(player1, player2)
  combo = {}
  player1.each do |p1, v1|
    player2.each do |p2, v2|
      combo[[p1, p2]] = v1 * v2
    end
  end
  combo
end

score_pairs = { [[3, 0], [7, 0]] => 1 }
p1_wins = 0
p2_wins = 0
loop do
  multiverse = {}
  p1_count = 0
  p2_count = 0
  score_pairs.each do |key, value|
    next if value == 0
    player1 = generate_possible_outcomes(key[0])
    amount = player1.values.sum
    player1 = player1.select { |possible, _| possible[1] < 21 }
    p1_count += player1.values.sum
    p1_wins += (amount - player1.values.sum) * value
    # binding.pry
    if player1.empty?
      score_pairs[key] = 0
      next
    else
      player2 = generate_possible_outcomes(key[1])
      # binding.pry
      player2_removed = player2.reject { |possible, _| possible[1] < 21 }
      player2.delete_if { |possible, _| possible[1] >= 21 }
      p2_count += player2.values.sum
      if player2_removed.empty? == false
        player2_removed.each do |_, removed_amount|
          p2_wins += (removed_amount * player1.values.sum) * value
        end
      end
      # binding.pry
      if player2.empty?
        score_pairs[key] = 0
        next
      else
        combinations = get_combinations(player1, player2)
        combinations.each do |combo, total|
          if multiverse[combo]
            multiverse[combo] += total * value
          else
            multiverse[combo] = total * value
          end
        end
        score_pairs[key] = 0
      end
    end
  end
  p [p1_count, p2_count]
  multiverse.each do |key, value|
    if score_pairs[key]
      score_pairs[key] += value
    else
      score_pairs[key] = value
    end
  end
  p score_pairs.values.sum
  # binding.pry
  break if score_pairs.values.sum == 0
end
p p1_wins
p p2_wins
