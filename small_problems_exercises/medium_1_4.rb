=begin

P:
- input: number of switches
- output: lights that are still on
- rules:
  - light can only be either on or off, each toggle change the state of the light from one to another
  - all lights are initially off
  - toggle from the first light to the last every pass
  - each pass only toggle the light no. that can be divided by the no. of pass with 0 remainder
  - return an array
  - possible for nothing is on? return []?

D:
- input: int
- light no. and states: hash
- output: array

A:
- for light states, -1 = off, 1 = on
- for n lights, initial a hash, keys are integers from 1 to n. the values are all -1
- iterate through each round (1 - n)
  - iterate through each keys:
    - toggle the light and change its value for the light that its key % current round no. == 0
  end
  end
- get the keys from the hash which value == 1 (return must be an array)

Toggle the light:
- if value is 1, then return -1
- if value is -1, then return 1

=end

def lights(switches_count)
  lights = initialize_lights(switches_count)
  i = 1
  while i <= switches_count
    lights.each do |key, value|
      lights[key] = toggle_light(value) if key % i == 0
    end
    on_lights = lights.select { |_, value| value == 1 }.keys
    off_lights = lights.select { |_, value| value == -1 }.keys
    announcement(on_lights, off_lights)
    i += 1
  end
  lights.select { |_, value| value == 1 }.keys
end

def toggle_light(state)
  return 1 if state == -1
  -1
end

def initialize_lights(n)
  lights = {}
  i = 1
  while i <= n
    lights[i] = -1
    i += 1
  end
  lights
end

def announcement(on_lights, off_lights)
  puts "lights #{off_lights} are now off, #{on_lights} are now on."
end

lights(10)