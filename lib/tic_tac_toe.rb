# frozen_string_literal: true

# A command line implementation of the classic game, using classes

# for playing the actual game
class Game
  def initialize
    @current_player = ''
    @counter = 0
    @board = Board.new
  end

  def play_game
    determine_first_player
    play_turns
    puts declare_winner
  end

  # get a valid first player from the user
  def determine_first_player
    puts 'Who is going first, X or O?'
    first_player = obtain_letter
    while first_player != 'X' && first_player != 'O'
      puts 'Please enter X or O'
      first_player = obtain_letter
    end
    @current_player = first_player
  end

  def game_over?
    @board.determine_winner == 'X' ||
      @board.determine_winner == 'O' || @counter == 9
  end

  # while the game is not over, play a turn:
  # display the board, get the current player's move, display the new board
  def play_turns
    until game_over?
      puts "It's #{@current_player}'s turn!"
      @board.display
      process_input(@current_player)
      @board.display
      @current_player = @current_player == 'X' ? 'O' : 'X'
      @counter += 1
    end
  end

  # check for a tie or a winner (used when counter is at 9)
  def tie_or_win
    @board.determine_winner == :no_winner ? "It's a tie!" : "#{@board.determine_winner} wins!"
  end

  # at the end of the game, display the game status (winner or "it's a tie")
  def declare_winner
    @counter == 9 ? tie_or_win : "#{@board.determine_winner} wins!"
  end

  # get a proper move from the current player, and store it in the board
  def process_input(token)
    puts 'Select one of the available slots'
    input = valid_input(obtain_number)
    @board.populate_square(token, input)
  end

  private

  # check that the input is an integer between 1 and 9
  def valid_input(input)
    until correct_number?(input) && not_played_yet?(input)
      puts 'Please enter an integer between 1 and 9 that has not been played yet'
      input = gets.chomp.to_i
    end
    input
  end

  def correct_number?(input)
    input.between?(1, 9)
  end

  # check that the input has not been played yet
  def not_played_yet?(input)
    !@board.occupied?(input)
  end
end

def obtain_letter
  gets.chomp.upcase
end

def obtain_number
  gets.chomp.to_i
end

# the representation of the game board
class Board
  def initialize
    @grid = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @win_possibilities = win_possibilities
  end

  # create the win possibilities array
  def win_possibilities
    win_possibilities = []
    [0, 3, 6].each do |i|
      win_possibilities.push([i, i + 1, i + 2])  # wins via rows
    end
    [0, 1, 2].each do |i|
      win_possibilities.push([i, i + 3, i + 6])  # wins via columns
    end
    win_possibilities.push([0, 4, 8])  # win via diagonal
    win_possibilities.push([2, 4, 6])  # win via diagonal
  end

  # check if a board square already has an X or an O
  def occupied?(input)
    @grid[input - 1] == 'X' || @grid[input - 1] == 'O'
  end

  # populate a board square
  def populate_square(user, input)
    @grid[input - 1] = user
  end

  # determine if there is a game winner and return that winner or :no_winner
  def determine_winner
    win_possibilities = @win_possibilities.dup.map(&:dup) # because it is a 2D array
    win_possibilities.each do |win_possibility|
      win_possibility.each_with_index do |grid_element, i|
        win_possibility[i] = @grid[grid_element]
        return win_possibility[0] if win_possibility.uniq.size == 1
      end
    end
    :no_winner
  end

  # display the board
  def display
    puts <<-HEREDOC

              ||         ||
              ||         ||
         #{@grid[0]}    ||    #{@grid[1]}    ||    #{@grid[2]}
              ||         ||
              ||         ||
     =========||=========||=========
              ||         ||
              ||         ||
         #{@grid[3]}    ||    #{@grid[4]}    ||    #{@grid[5]}
              ||         ||
              ||         ||
     =========||=========||=========
              ||         ||
              ||         ||
         #{@grid[6]}    ||    #{@grid[7]}    ||    #{@grid[8]}
              ||         ||
              ||         ||

    HEREDOC
  end
end

game = Game.new
game.play_game
