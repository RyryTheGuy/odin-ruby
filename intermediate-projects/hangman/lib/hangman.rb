require 'json'

class Hangman
  def initialize
    @word_to_guess = ""
    @hidden_word = ""
    @incorrect_letters = []
    @strikes = 0
    @winner = false
    @saved = false
    @file_name = ""
  end

  def start_game
    print_intro 
    print_intro until valid_input?(gets.chomp)
    play_game
  end

  private
  def print_intro
    puts "--------------------------------------------- HANGMAN ---------------------------------------------"
    puts "   Try to guess a random word selected by the computer by guessing what letters are in the word."
    puts "   If you guess a letter that isn't in the word, you get a strike. 7 Strikes is Game over."
    puts "---------------------------------------------------------------------------------------------------"
    puts 
    puts "Please enter the number to select an option:"
    puts "\t1. New Game"
    puts "\t2. Load Game"
  end
  
  def valid_input?(input)
    # Make sure the user selects an option
    if input[0] == "1" || input[0] == "2"
      @option = input[0]
      return true
    end
    
    puts "Please select one of the options..."
    puts
    false
  end

  def get_word
    # Grab a random word from the file
    File.open("5desk.txt", "r") do |file|
      @word_to_guess = file.readlines[rand(0..61405)].chomp
    end

    # Save the word as underscores
    create_underscores(@word_to_guess)
  end

  def create_underscores(word)
    # Convert the word to underscores
    @hidden_word = word.gsub(/\w/, "_").strip
  end

  def play_game
    # Create a new word or load a game
    @option == "1" ? get_word : load_game

    # Play until player wins, loses, or saves the game
    until @winner || @strikes == 7 || @saved
      print_status
      guess_letter
    end

    # Output winner/loser text or tell the user they saved
    puts @winner ? "You win! The word was #{@word_to_guess}." : @strikes == 7 ? "You lose, the word was #{@word_to_guess}." : "Game Saved."
  end

  def load_game
    # Read and parse the json file
    file = File.read("hangman.json")
    data_hash = JSON.parse(file)

    # Save the data from the file to the instance variables
    @word_to_guess = data_hash["word_to_guess"]
    @hidden_word = data_hash["hidden_word"]
    @incorrect_letters = data_hash["incorrect_letters"]
    @strikes = data_hash["strikes"].to_i
  end

  def save_game
    # Save the instance variables to a hash
    save_data = {
      :word_to_guess => @word_to_guess,
      :hidden_word => @hidden_word,
      :incorrect_letters => @incorrect_letters,
      :strikes => @strikes
    }

    # JSON the data and save the file
    File.open("hangman.json", "w") { |file| file << JSON.pretty_generate(save_data) }
  end 

  # Print out how many strikes the user has gotten, what incorrect letters were guessed and the hidden word
  def print_status
    puts 
    puts "Total Strikes: #{@strikes} / 7"
    puts "Incorrect Letters: #{@incorrect_letters.join(', ')}"
    puts "Word: #{@hidden_word.split("").join(" ")}"
    puts "Guess a letter or enter 1 to save and exit the game:"
  end

  def guess_letter()
    letter = ""
    loop do
      letter = gets.chomp.downcase
      break if validate_letter?(letter)
    end
    
    # Reveal all the letters that occur in the word, otherwise add a strike and add the guessed letter to the incorrect letters
    if @word_to_guess.include?(letter[0]) && !@saved
      reveal_letter(letter[0])
      @winner = true unless @hidden_word.include?("_")
    else
      @strikes += 1
      @incorrect_letters << letter[0]
    end
  end
  
  def validate_letter?(letter)
    # Nothing was inputted
    return false if letter == ""
    # Allow the user to enter a number to save the game
    if letter[0] == "1"
      save_game
      @saved = true
      return true
    end
    # Any non letter was entered
    if !letter[0].match?(/[a-z]/i)
      puts "Please input a letter"
      return false
    end
    
    # Any letter that was already guessed
    if @incorrect_letters.include?(letter[0]) || @hidden_word.include?(letter[0])
      puts "You already guessed that letter!"
      return false
    end
    true
  end

  def reveal_letter(letter)
    @word_to_guess.split("").each_with_index do |char, index| 
      @hidden_word[index] = char if char == letter
    end
  end
end

h = Hangman.new
h.start_game