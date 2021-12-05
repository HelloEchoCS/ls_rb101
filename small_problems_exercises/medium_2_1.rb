=begin
P
- Find the longest sentence in a text file, return the sentence and its word count.
- input: a text file
- output: a string (the longest sentence), and an int (word count of the sentence)
- rules:
  - sentence end with: ".", "!", and "?"
  - anything sit between two consecutive spaces count as a word
  - should be able to directly read a txt file

D
- input: txt file
- output: a string and an integer

A
- iterate through each sentence:
  - split the sentence into words
  - count the number of words
  - compare the number with word_count, if larger
    - update the word count
    - join the sentence back then store it




=end

data = File.read("pg84.txt")
# sentences = data.split(/\.|\?|!/)
# largest_count = 0
# longest_sentence = ""
# sentences.each do |sentence|
#   word_count = sentence.split(" ").count
#   if word_count > largest_count
#     largest_count = word_count
#     longest_sentence = sentence
#   end
# end

# def longest_sentence(data)
#   words = data.split(" ")
#   largest_count = 0
#   longest_sentence = []
#   word_count = 0
#   sentence = []
#   words.each do |word|
#     sentence << word
#     word_count += 1
#     if word[-1] == "." || word[-1] == "?" || word[-1] == "!"
#       if word_count > largest_count
#         largest_count = word_count
#         longest_sentence = sentence
#       end
#       word_count = 0
#       sentence = []
#     end
#   end
#   p longest_sentence.join(" ")
#   p largest_count
# end

# longest_sentence(data)

def longest_para(data)
  paragraph = data.split("\r\n\r\n")
  largest_count = 0
  longest_para = ""
  paragraph.each do |para|
    word_count = para.split(" ").count
    if word_count > largest_count
      largest_count = word_count
      longest_para = para
    end
  end
  p longest_para
  p largest_count
end

longest_para(data)
