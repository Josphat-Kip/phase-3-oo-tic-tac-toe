
# Pseudo code:
# 
# 1. Initialize the board with empty spaces
# 2. Create an array of winning combinations 
# 3. Create a display_board method to show the current board
# 4. Create an input_to_index method to convert user input to index
# 5. Create a move method to move the token on the board
# 6. Create a position_taken? method to check if the board is already taken
# 7. Create a valid_move? method to check if the move is valid 
# 8. Create a turn_count method to count the turns
# 9. Create a current_player method to figure out which player is currently playing
# 10. Create a turn method to prompt the user to make a move and to execute the move
# 11. Create a won? method to check if the game is won
# 12. Create a full? method to check if the board is full
# 13. Create a draw? method to check if the game is draw
# 14. Create an over? method to check if the game is over
# 15. Create a winner method to figure out the winner
# 16. Create a play method to start the game

# this is the maingame class which encapsulates all methods build
require "pry"

class TicTacToe
  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(board_index, token="X")
    @board[board_index] = token
  end

  def position_taken?(prospective_index)
    @board[prospective_index] != " "
  end

  def valid_move?(index_position)
    !position_taken?(index_position) && (0..8).include?(index_position)
  end

  def turn_count
    # binding.pry
    @board.count {|move| move != " "}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    puts "Enter your move. Should be within range (1-9):"
    user_input = gets.chomp()
    index = input_to_index(user_input)
    if valid_move?(index)
      player_token = current_player
      move(index, player_token)
      display_board
    else
      turn
    end
  end

  def won?
    WIN_COMBINATIONS.any? do |combination|
      if position_taken?(combination[0]) 
        if @board[combination[0]] == @board[combination[1]] && @board[combination[1]] == @board[combination[2]]
          return combination
        end
      end
      # binding.pry
    end
    # binding.pry
  end

  def full?
    !@board.include? " "
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || full?
  end

  def winner
    if won?
      winning_combinations = won?
      @board[winning_combinations[0]]
    end
  end

  def play
    until over? do
      turn
      if draw?
        return
      end
    end
    puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
  end

end