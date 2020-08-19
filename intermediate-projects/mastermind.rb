# Possible colors [ R, G, B, Y, P, O ]

class Mastermind
  def start_game()
    # Randomly Create a combination of 4 colors and print out the rules to the user
    print_rules
    create_combo
    
    @rounds = 0
    @win_flag = false
    until @rounds == 12 || @win_flag
      guess_combo
      @rounds += 1
    end

    end_game
  end

  private
  def print_rules
    puts "-------------------------------- MASTERMIND RULES --------------------------------"
    puts "  - The player must guess a 4 color combination code within 12 guesses. "
    puts "  - The color combination is randomized and allows duplicates. "
    puts "  - There are 6 possible colors: R, G, B, Y, P, O"
    puts "  - Valid guesses: 'RGBY' or 'R g B y' or 'R,G,B,Y' "
    puts "        NOTE: The position of the colors matter."
    puts "  - The player will receive feedback on whether their guess had the correct colors"
    puts "        or the correct color and location."
    puts "----------------------------------- GOOD LUCK! -----------------------------------"
    puts 
  end

  def create_combo
    # Create the code randomly
    @answer = []

    for i in 1..4 do
      r = rand(1..6)
      case r
      when 1
        @answer << "R"
      when 2
        @answer << "G"
      when 3
        @answer << "B"
      when 4
        @answer << "Y"
      when 5
        @answer << "P"
      when 6
        @answer << "O"
      end
    end
  end

  def guess_combo
    loop do
      # Prompt the user to enter their guess
      puts
      puts "Guesses remaining: #{12-@rounds}"
      puts "Enter your 4 color guess:"
      user_input = gets.chomp.upcase.split("")
      
      # Data validate the user's guess
      break if validate_guess(user_input)
      puts "Invalid guess. Please enter a valid guess."
    end
    # Give feedback on the user's guess
    give_feedback
  end

  def validate_guess(guess)
    @user_guess = guess.filter do |value|
        value if value.match?(/[RGBYPO]/)
    end
    return @user_guess.length == 4
  end

  def give_feedback
    # Checks to see if the user won with their guess
    if @user_guess == @answer
      @win_flag = true
      return
    end

    temp = Array.new(@answer)
    @correct_feedback = {:correct_spot_and_color => 0, :correct_color => 0}

    # Loop through the user's guess
    @user_guess.each_with_index do |value, index|
      # Find out how many colors were correct in total
      if temp.include?(value)
        temp.delete_at(temp.index(value))
        @correct_feedback[:correct_color] += 1
      end

      # Find out how many colors were in the right spot
      if @answer[index] == value
        @correct_feedback[:correct_spot_and_color] += 1
        @correct_feedback[:correct_color] -= 1
      end
    end
    # Show the user their guess and what they got right 
    print_feedback
  end

  def print_feedback
    puts
    puts "Guessed: #{@user_guess.join}"
    puts "Correct Position and Color: #{@correct_feedback[:correct_spot_and_color]}"
    puts "Correct Color, Incorrect position: #{@correct_feedback[:correct_color]}"
    puts
  end

  def end_game
    if @win_flag
      puts "You won!"
    else
      puts "You lost!"
    end
  end
end

mm = Mastermind.new()
mm.start_game()