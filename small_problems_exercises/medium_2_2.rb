WORD_BLOCK = { B:'O', X:'K', D:'Q', C:'P', N:'A', G:'T', R:'E', F:'S', J:'W', H:'U', V:'I', L:'Y', Z:'M' }


=begin
P
- input: a string
- output: boolean
- rules:
  - input word can not use both letters from any given block
  - in other words, each block can only be used once
  - case insensitive when compare

D
- input: a string
- output: boolean

A
- iterate through the WORD_BLOCK
  - if both key (convert to string) and value are present in the input string (convert to uppercase), return false
  - else, return true

=end

def block_word?(str)
  WORD_BLOCK.each do |key, value|
    return false if str.upcase.include?(key.to_s) && str.upcase.include?(value)
  end
  true
end

p block_word?('BATCH')
p block_word?('BUTCH')
p block_word?('jest')
