require 'yaml'
require 'pry'

data = YAML.load_file('day_16.yml')
HEX_TO_BIN = { '0' => '0000',
               '1' => '0001',
               '2' => '0010',
               '3' => '0011',
               '4' => '0100',
               '5' => '0101',
               '6' => '0110',
               '7' => '0111',
               '8' => '1000',
               '9' => '1001',
               'A' => '1010',
               'B' => '1011',
               'C' => '1100',
               'D' => '1101',
               'E' => '1110',
               'F' => '1111'
}

=begin
- parse the hex to binaries
- parse_packet()
  - start_index = current index
  - check version
  - check type
    - if type == 4
      - loop
        - get prefix, `pointer` += 1
        - get next 4 bit, save it to `literal`, `pointer` += 4
        - break if prefix == '0'
    - else
      - check length type
      - if length type == 0
        - check next 15 bits, calculate `packet_length`, `pointer` += 15
        - distance = 0
        - loop until distance = `packet_length`
          - distance += parse_packet()
      - if length type == 1
        - check next 11 bits, get total number of packets, `pointer` += 11
        - iterate x times, do parse_packet()
  - pointer - start_index

=end

def hex_to_binary(str)
  str.chars.map { |char| HEX_TO_BIN[char] }.join
end

def parse_packet(packet, pointer)
  pointer[:p] += 3
  if packet[pointer[:p]..(pointer[:p] + 2)].to_i(2) == 4 # type ID = 4
    pointer[:p] += 3
    literal = []
    loop do
      prefix = packet[pointer[:p]]
      pointer[:p] += 1
      literal << packet[pointer[:p]..(pointer[:p] + 3)]
      pointer[:p] += 4
      break if prefix == '0'
    end
    return literal.join.to_i(2)

  else
    values = []
    type_id = packet[pointer[:p]..(pointer[:p] + 2)].to_i(2)
    pointer[:p] += 3
    if packet[pointer[:p]] == '0' # length type is 0
      pointer[:p] += 1
      packet_length = packet[pointer[:p]..(pointer[:p] + 14)].to_i(2)
      pointer[:p] += 15
      distance = 0
      while distance != packet_length
        start_index = pointer[:p]
        values << parse_packet(packet, pointer)
        distance += pointer[:p] - start_index
      end
    else
      pointer[:p] += 1
      packet_count = packet[pointer[:p]..(pointer[:p] + 10)].to_i(2)
      pointer[:p] += 11
      packet_count.times do
        start_index = pointer[:p]
        values << parse_packet(packet, pointer)
      end
    end
    case type_id
    when 0
      return values.sum
    when 1
      return values.reduce(:*)
    when 2
      return values.min
    when 3
      return values.max
    when 5
      return 1 if values[0] > values[1]
      return 0
    when 6
      return 1 if values[0] < values [1]
      return 0
    when 7
      return 1 if values[0] == values [1]
      return 0
    end
  end
  return value if packet[pointer[:p]..(packet.length - 1)].chars.uniq.join == '0'
end

binaries = hex_to_binary(data)
pointer = {p: 0}
p parse_packet(binaries, pointer)
