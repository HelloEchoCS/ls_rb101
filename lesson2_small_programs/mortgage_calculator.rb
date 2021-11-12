# Initialize & language configuration

require "yaml"
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')
LANGUAGE = 'en'

def valid_input?(input)
  is_valid = integer?(input) || float?(input)
  not_negative = (input.to_f >= 0)
  is_valid && not_negative
end

def integer?(input)
  input.to_i.to_s == input
end

def float?(input)
  input.to_f.to_s == input
end

# Prompt formatting method

def display(message, additional_num=false, message2=nil)
  message = MESSAGES[LANGUAGE][message]
  message = message + " " + additional_num.to_s if additional_num
  message = message + " " + MESSAGES[LANGUAGE][message2] if message2
  puts(">>> " + message)
end

def retrieve_loan_amount
  loan_amount = ''
  display('input_loan_amount')
  loop do
    loan_amount = gets.chomp
    break if valid_input?(loan_amount)
    display('invalid_number')
  end
  loan_amount.to_f
end

def retrieve_apr
  apr = ''
  display('input_apr')
  loop do
    apr = gets.chomp
    break if valid_input?(apr)
    display('invalid_number')
  end
  apr.to_f / 100
end

def retrieve_duration_year
  duration_year = ''
  display('input_loan_duration_year')
  loop do
    duration_year = gets.chomp
    break if integer?(duration_year)
    display('invalid_number')
  end
  duration_year.to_i
end

def retrieve_duration_month
  duration_month = ''
  display('input_loan_duration_month')
  loop do
    duration_month = gets.chomp
    break if integer?(duration_month)
    display('invalid_number')
  end
  duration_month.to_i
end

def total_month(year, month)
  year * 12 + month
end

def calculate_monthly_interest_rate(apr)
  (apr / 12 * 100).round(2)
end

def monthly_payment(loan_amount, apr, months)
  monthly_interest_rate = apr / 12
  if monthly_interest_rate == 0
    result = loan_amount / months
  else
    result = loan_amount * (monthly_interest_rate /
             (1 - (1 + monthly_interest_rate)**(0 - months)))
  end
  result.round(2)
end

Kernel.system('clear')
display('welcome')

loop do
  loan_amount = retrieve_loan_amount()
  apr = retrieve_apr()
  duration_year = retrieve_duration_year()
  duration_month = retrieve_duration_month()

  total_duration_month = total_month(duration_year, duration_month)
  monthly_interest_rate = calculate_monthly_interest_rate(apr)
  monthly_payment = monthly_payment(loan_amount, apr, total_duration_month)

  display('monthly_interest_rate', monthly_interest_rate, 'percent')
  display('loan_duration_in_months', total_duration_month, 'string_month')
  display('monthly_payment', monthly_payment)

  display('start_again')
  answer = gets.chomp.downcase
  break if answer != 'y'
end

display('thank_you')
