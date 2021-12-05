=begin

minilang(str):
- initialize register to 0
- initialize stack to []
- divide the string into array by " "
- iterate through the string, for each element:
  - if it's an int, call place_value method, pass the int and register as arguments
  - if it's a string, case string:
    - 'PUSH': call push method, pass the stack as an argument
    - 'ADD': call add mehtod, pass stack & register as arguments
    - 'SUB': call sub method, pass stack & register as arguments
    - 'MULT': call mult method, pass stack & register as arguments
    - 'DIV': call div method, pass stack & register as arguments
    - 'MOD': call mod method, pass stack & register as arguments
    - 'POP': call pop method, pass stack & register as arguments
    - 'PRINT': call print method, pass register as argument
- end

place_value method:
- change the register value

push method
- push the value in register to the stack

add method
- pop the value from the stack, add it to the register value, reassign the register value to the result

sub method
- pop the value from the stack, subtract it from the register value, reassign the register value to the result

mult method
- pop the value from the stack, multiply it by the register value, reassign the register value to the result

div method
- pop the value from the stack, divides it into the register value, reassign the register value to the result

mod method
- pop the value from the stack, divides it into the register value, get the remainder then reassign the register value to the remainder

pop method
- pop the value from the stack, reassign the register to the value

print method
- print the register value

=end

def minilang(str)
  register = 0
  stack = []
  str.split(" ").each do |command|
    if command.to_i.to_s == command
      register = command.to_i
    else
      case command
      when "PUSH"
        stack.push(register)
      when "ADD"
        register += stack.pop
      when "SUB"
        register -= stack.pop
      when "MULT"
        register *= stack.pop
      when "DIV"
        register /= stack.pop
      when "MOD"
        register %= stack.pop
      when "POP"
        register = stack.pop
      when "PRINT"
        p register
      end
    end
  end
end

minilang('PRINT')
# 0

minilang('5 PUSH 3 MULT PRINT')
# 15

minilang('5 PRINT PUSH 3 PRINT ADD PRINT')
# 5
# 3
# 8

minilang('5 PUSH POP PRINT')
# 5

minilang('3 PUSH 4 PUSH 5 PUSH PRINT ADD PRINT POP PRINT ADD PRINT')
# 5
# 10
# 4
# 7

minilang('3 PUSH PUSH 7 DIV MULT PRINT ')
# 6

minilang('4 PUSH PUSH 7 MOD MULT PRINT ')
# 12

minilang('-3 PUSH 5 SUB PRINT')
# 8

minilang('6 PUSH')
# (nothing printed; no PRINT commands)

