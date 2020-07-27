# Tic Tac Toe
class Board
  @@board_arr = []

  def initialize
    @@board_arr = [1,2,3,4,5,6,7,8,9]
    start_game()
  end
  
  private
  def start_game
    @winner = false
    @last_turn = "X"
    until @winner
      show_board()
      @last_turn == "X" ? player_turn("O") : player_turn("X")
      check_for_winner()
    end
    show_board()
    puts @last_turn == "D" ? "Draw! No one wins!" :  @last_turn == "O" ? "Player 1 (O) Wins!" : "Player 2 (X) Wins!"
  end
   
  def show_board
    puts "\n #{@@board_arr[0]} | #{@@board_arr[1]} | #{@@board_arr[2]}\n------------\n #{@@board_arr[3]} | #{@@board_arr[4]} | #{@@board_arr[5]}\n------------\n #{@@board_arr[6]} | #{@@board_arr[7]} | #{@@board_arr[8]}"
  end

  def player_turn(mark)
    puts mark == "O" ? "Player 1 (O) enter a number to claim a section." : "Player 2 (X) enter a number to claim a section."

    while true
      position = gets.chomp.to_i
      break if claim_section(position, mark)
    end

    @last_turn = mark == "O" ? "O" : "X"
  end

  def claim_section(pos, mark)
    if (1..9).include?(pos)
      if @@board_arr[pos - 1] != "X" && @@board_arr[pos - 1] != "O"
        @@board_arr[pos - 1] = mark
        return true
      end
      puts "That spot isn't available!"
    else
      puts "Please enter a valid number."
    end
    false
  end

  def check_for_winner
    if @last_turn == "O"
      o_positions = []
      @@board_arr.each_with_index do |value, index|
        o_positions << index if value == "O"
      end

      @winner = true if o_positions.include?(0) && o_positions.include?(1) && o_positions.include?(2)
      @winner = true if o_positions.include?(0) && o_positions.include?(3) && o_positions.include?(6)
      @winner = true if o_positions.include?(0) && o_positions.include?(4) && o_positions.include?(8)
      @winner = true if o_positions.include?(1) && o_positions.include?(4) && o_positions.include?(7)
      @winner = true if o_positions.include?(2) && o_positions.include?(4) && o_positions.include?(6)
      @winner = true if o_positions.include?(2) && o_positions.include?(5) && o_positions.include?(8)
      @winner = true if o_positions.include?(3) && o_positions.include?(4) && o_positions.include?(5)
      @winner = true if o_positions.include?(6) && o_positions.include?(7) && o_positions.include?(8)
    else 
      x_positions = []
      @@board_arr.each_with_index do |value, index|
        x_positions << index if value == "X"
      end
      
      @winner = true if x_positions.include?(0) && x_positions.include?(1) && x_positions.include?(2)
      @winner = true if x_positions.include?(0) && x_positions.include?(3) && x_positions.include?(6)
      @winner = true if x_positions.include?(0) && x_positions.include?(4) && x_positions.include?(8)
      @winner = true if x_positions.include?(1) && x_positions.include?(4) && x_positions.include?(7)
      @winner = true if x_positions.include?(2) && x_positions.include?(4) && x_positions.include?(6)
      @winner = true if x_positions.include?(2) && x_positions.include?(5) && x_positions.include?(8)
      @winner = true if x_positions.include?(3) && x_positions.include?(4) && x_positions.include?(5)
      @winner = true if x_positions.include?(6) && x_positions.include?(7) && x_positions.include?(8)
    end
    check_for_draw()
  end

  def check_for_draw
    if @winner == false && !@@board_arr.any?(Integer)
      @winner = true
      @last_turn = "D"
    end
  end
end

board = Board.new()