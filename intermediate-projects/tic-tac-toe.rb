# Tic Tac Toe
class Board

  def initialize
    # Populate Board with open positions
    @board_arr = [1,2,3,4,5,6,7,8,9]
    # Start the game
    start_game()
  end
  
  private
  def start_game
    # Winner flag
    @winner = false
    # Indicate who the last player to go was
    @last_turn = "X"
    # Keep playing til there is a winner
    until @winner
      # Show the Board to the players
      show_board()
      # Decide who's turn it is based on who went last
      @last_turn == "X" ? player_turn("O") : player_turn("X")
      check_for_winner()
    end
    # Once the game is over, Show the board and display whether it was a draw or who won
    show_board()
    puts @last_turn == "D" ? "Draw! No one wins!" :  @last_turn == "O" ? "Player 1 (O) Wins!" : "Player 2 (X) Wins!"
  end
   
  def show_board
    # Displays the board to the players
    puts "\n #{@board_arr[0]} | #{@board_arr[1]} | #{@board_arr[2]}\n------------\n #{@board_arr[3]} | #{@board_arr[4]} | #{@board_arr[5]}\n------------\n #{@board_arr[6]} | #{@board_arr[7]} | #{@board_arr[8]}"
  end

  def player_turn(mark)
    # Prompt the correct player to play their turn
    puts mark == "O" ? "Player 1 (O) enter a number to claim a section." : "Player 2 (X) enter a number to claim a section."

    # Validate whether the move the player makes is valid
    while true
      position = gets.chomp.to_i
      break if claim_section(position, mark)
    end

    @last_turn = mark == "O" ? "O" : "X"
  end

  def claim_section(pos, mark)
    # Make sure the user entered a valid number
    if (1..9).include?(pos)
      # Make sure there isn't a mark at the position already
      if @board_arr[pos - 1] != "X" && @board_arr[pos - 1] != "O"
        # Add the player's mark to the board and return true to let the next player go
        @board_arr[pos - 1] = mark
        return true
      end
      # Let the user know that they can't pick that spot
      puts "That spot isn't available!"
    else
      # Tell the user to input a valid number
      puts "Please enter a valid number."
    end
    # Return false so the same player can input another number because the one they entered wasn't valid
    false
  end

  def check_for_winner
    # Check to see whoever was last to go won
    # All possible winning combinations
    if [@board_arr[0], @board_arr[1], @board_arr[2]].all?(@last_turn) ||
        [@board_arr[0], @board_arr[3], @board_arr[6]].all?(@last_turn) ||
        [@board_arr[0], @board_arr[4], @board_arr[8]].all?(@last_turn) ||
        [@board_arr[1], @board_arr[4], @board_arr[7]].all?(@last_turn) ||
        [@board_arr[2], @board_arr[4], @board_arr[6]].all?(@last_turn) ||
        [@board_arr[2], @board_arr[5], @board_arr[8]].all?(@last_turn) ||
        [@board_arr[3], @board_arr[4], @board_arr[5]].all?(@last_turn) ||
        [@board_arr[6], @board_arr[7], @board_arr[8]].all?(@last_turn)
      @winner = true
    else
      # If there is no winner then check for a draw
      check_for_draw()
    end
  end

  def check_for_draw
    # Draws only occur if there is no winner and the board has no more open positions to play
    if @winner == false && !@board_arr.any?(Integer)
      @winner = true
      @last_turn = "D"
    end
  end
end

# Init the board so people can play Tic-Tac-Toe
board = Board.new()