# Q1

# Q2
# "!" in Ruby has two functions.
# 1. If precedes an object, it turns the truthiness of the object into falsyness. If precedes a "=", it means the operands are different.
# 2. If comes after a method, it means the method would mutate its caller.
# "?" in Ruby usually comes after a method, it means the method will return a boolean value (true or false).

# Q3
advice = "Few things in life are as important as house training your pet dinosaur."
advice = advice.split(" ")
advice[6] = "urgent"
advice = advice.join(" ")
puts advice

# or better, just use gsub! ...

# Q4

# Q5
(10..100).include?(42)
# or use .cover?

# Q6
famous_words = "seven years ago..."
"Four score and " << famous_words
famous_words = "Four score and " + famous_words
famous_words.insert(0, "Four score and ")
famous_words.prepend("Four score and ")

# Q7
flintstones = ["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
flintstones.flatten!

# Q8
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
flintstones.select!{ |key, value| key == "Barney" }
flintstones.assoc("Barney")