# Possible colors [ R, G, B, Y, P, O ]

class Mastermind
  def start_game()
    create_combo()
    
    counter = 0
    @win_flag = false
    until counter == 12 || @win_flag
      guess_combo()
      counter += 1
    end
  end

  private
  def create_combo()
    # Create the code randomly and tell the user how to play
    @answer = ["R", "R", "G", "G"]
  end

  def guess_combo()
    loop do
      puts "Enter your 4 color guess:"
      user_input = gets.chomp.split("")
      
      break if validate_guess(user_input)
      puts "Invalid guess. Please enter a valid guess."
    end
    
    give_feedback(@user_guess)
  end

  def validate_guess(guess)
    @user_guess = guess.filter do |value|
        value.upcase! if value.match?(/[RGBYPO]/i)
    end
    return @user_guess.length == 4 ? true : false
  end

  def give_feedback(guess)
    @correct_spot_and_color = 0 
    @correct_color = 0
    @answer.each_with_index do |val, index|
      
    end
  end
end

mm = Mastermind.new()
mm.start_game()