VALID_CHOICES = { 'r' => 'Rock',
                  'p' => 'Paper',
                  'sc' => 'Scissors',
                  'l' => 'Lizard',
                  'sp' => 'Spock' }
WIN = { Rock: ['Scissors', 'Lizard'],
        Paper: ['Rock', 'Spock'],
        Scissors: ['Paper', 'Lizard'],
        Lizard: ['Paper', 'Spock'],
        Spock: ['Rock', 'Scissors'] }

def prompt(message)
  Kernel.puts(">>> #{message}")
end

def clear_screen
  Kernel.system('clear')
end

def list_of_choices
  choices_prompt = "Choose one:\n"
  VALID_CHOICES.each do |key, value|
    choices_prompt += "#{key} for #{value}\n"
  end
  choices_prompt
end

def retrieve_player_choice
  choice = ''
  loop do
    prompt(list_of_choices)
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.keys.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end
  VALID_CHOICES[choice]
end

def display_result(player, computer)
  if WIN[player.to_sym].include?(computer)
    prompt("You won!")
  elsif WIN[computer.to_sym].include?(player)
    prompt("You lose!")
  else
    prompt("You tie!")
  end
end

def update_score(player, computer, score)
  if WIN[player.to_sym].include?(computer)
    score[0] += 1
  elsif WIN[computer.to_sym].include?(player)
    score[1] += 1
  end
  score
end

def display_score(score)
  prompt("[Score] you: #{score[0]}, computer: #{score[1]}")
  puts ""
end

def we_have_a_winner?(score)
  score[0] == 3 || score[1] == 3
end

def announce_winnier(score)
  prompt("You are the grand winner!") if score[0] == 3
  prompt("Computer is the grand winner!") if score[1] == 3
end

def retrieve_play_again_choice
  valid_answer = ['y', 'Y', 'n', 'N']
  answer = ''
  loop do
    prompt("Do you want to play again? (Y/N)")
    answer = Kernel.gets().chomp().downcase()
    if valid_answer.include?(answer)
      break
    else
      prompt("That's not a valid choice, please choose again.")
    end
  end
  answer
end

def play_again?(answer)
  return true if answer == 'y'
  return false if answer == 'n'
end

# Program body

clear_screen
prompt('Welcome to "Rock, Paper, Scissors, Lizard, Spock"!')

loop do
  current_score = [0, 0]

  until we_have_a_winner?(current_score)
    player_choice = retrieve_player_choice()
    computer_choice = VALID_CHOICES.values.sample

    clear_screen
    prompt("You chose: #{player_choice}, computer chose: #{computer_choice}")

    display_result(player_choice, computer_choice)
    current_score = update_score(player_choice, computer_choice, current_score)
    display_score(current_score)
  end

  announce_winnier(current_score)

  break unless play_again?(retrieve_play_again_choice())
  clear_screen
end

prompt("Thank you for playing. Goodbye!")
