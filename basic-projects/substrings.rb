# Substrings Mini-Project

# Substrings will take an array of words to be matched against a word or string of words
def substrings(string, dictionary)
  # Split the string into an array of words and loop through them
  string.downcase.split(" ").reduce(Hash.new(0)) do |hash, word|
    # Loop through the dictionary of words
    dictionary.each do |d_word|
      # Add the dictionary word to the hash if it's included in the word and/or increment the matched word by 1 in the hash
      if word.include?(d_word)
        hash.has_key?(d_word) ? hash[d_word] += 1 : hash[d_word] = 1
      end
    end
    hash
  end
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("Howdy partner, sit down! How's it going?", dictionary)