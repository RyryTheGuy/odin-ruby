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
    if input[0] == "1" || input[0] == "2"
      @option = input[0]
      return true
    end
    
    puts "Please select one of the options..."
    puts
    false
  end

  def get_word
    File.open("5desk.txt", "r") do |file|
      @word_to_guess = file.readlines[rand(0..61405)].chomp
    end
    create_underscores(@word_to_guess)
  end

  def create_underscores(word)
    @hidden_word = word.gsub(/\w/, "_ ").strip
  end

  def play_game
    @option == "1" ? get_word : load_game
    until @winner || @strikes == 7 || @saved
      print_status
      guess_letter
    end
  end

  def load_game
    # TODO: Show user all saves and when the file was saved/created, Load game from JSON file

  end

  def save_game
    # ID the saves
    id = 1
    id += 1 until !File.exists?("saves/hangman_#{id}.json")

    # Assign a file name if the game is new (loaded games have a file)
    @file_name == "saves/hangman_#{id}.json" if @file_name == ""
    
    save_data = {
      :file_name => @file_name
      :word_to_guess => @word_to_guess,
      :hidden_word => @hidden_word,
      :incorrect_letters => @incorrect_letters,
      :strikes => @strikes, 
      :winner => @winner
    }

    File.open(@file_name, "w") { |file| file << JSON.pretty_generate(save_data) }
  end 

  # Print out how many strikes the user has gotten, what incorrect letters were guessed and the hidden word
  def print_status
    puts 
    puts "Total Strikes: #{@strikes} / 7"
    puts "Incorrect Letters: #{@incorrect_letters.join(', ')}"
    puts "Word: #{@hidden_word}"
    puts "Guess a letter or enter 1 to save and exit the game:"
  end

  def guess_letter()
    loop do
      break if validate_letter?(gets.chomp)
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
    true
  end
end

h = Hangman.new
h.start_game