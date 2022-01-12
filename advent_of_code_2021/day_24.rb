=begin
A
- Build ALU

- Test model number staring from 99999999999999


=end

require 'pry'

monad = File.read('day_24.txt').split(/\n/)

def initialize_memory
  {w: 0, x: 0, y: 0, z: 0}
end

def inp(var, input, memory)
  memory[var] = input
end

def add(var1, var2, memory)
  if var2.is_a?(Integer)
    memory[var1] += var2
  else
    memory[var1] += memory[var2]
  end
end

def mul(var1, var2, memory)
  if var2.is_a?(Integer)
    memory[var1] *= var2
  else
    memory[var1] *= memory[var2]
  end
end

def div(var1, var2, memory)
  if var2.is_a?(Integer)
    memory[var1] /= var2
  else
    memory[var1] /= memory[var2]
  end
end

def mod(var1, var2, memory)
  if var2.is_a?(Integer)
    memory[var1] %= var2
  else
    memory[var1] %= memory[var2]
  end
end

def eql(var1, var2, memory)
  if var2.is_a?(Integer)
    if memory[var1] == var2
      memory[var1] = 1
    else
      memory[var1] = 0
    end
  else
    if memory[var1] == memory[var2]
      memory[var1] = 1
    else
      memory[var1] = 0
    end
  end
end

def parse_program(str)
  str.split(" ")
end

def format_instruction!(arr)
  arr[1] = arr[1].to_sym
  if arr[0] != 'inp'
    if arr[2].to_i.to_s == arr[2] # integer
      arr[2] = arr[2].to_i
    else
      arr[2] = arr[2].to_sym
    end
  end
end


serial_number = 92915979999498
while serial_number >= 92915979999498
  memory = initialize_memory
  inp_counter = 0
  if serial_number.to_s.include?('0')
    serial_number -= 1
    next
  end
  monad.each do |line|
    serial_array = serial_number.to_s.chars.map { |char| char.to_i }
    instructions = parse_program(line)
    format_instruction!(instructions)

    case instructions[0]
    when 'inp'
      inp(instructions[1], serial_array[inp_counter], memory)
      inp_counter += 1
      p [instructions, memory[:z]]
    when 'add'
      add(instructions[1], instructions[2], memory)
    when 'mul'
      mul(instructions[1], instructions[2], memory)
    when 'div'
      div(instructions[1], instructions[2], memory)
    when 'mod'
      mod(instructions[1], instructions[2], memory)
    when 'eql'
      eql(instructions[1], instructions[2], memory)
    end


    # binding.pry
  end
  break if memory[:z] == 0
  serial_number -= 1
  p memory[:z]
end
p memory

# serial_number = 99
# memory = initialize_memory
# inp_counter = 0
# monad.each do |line|
#   serial_array = serial_number.to_s.chars.map { |char| char.to_i }

#   instructions = parse_program(line)
#   format_instruction!(instructions)

#   case instructions[0]
#   when 'inp'
#     inp(instructions[1], serial_array[inp_counter], memory)
#     inp_counter += 1
#   when 'add'
#     add(instructions[1], instructions[2], memory)
#   when 'mul'
#     mul(instructions[1], instructions[2], memory)
#   when 'div'
#     div(instructions[1], instructions[2], memory)
#   when 'mod'
#     mod(instructions[1], instructions[2], memory)
#   when 'eql'
#     eql(instructions[1], instructions[2], memory)
#   end
#   p [instructions, memory]

# end



