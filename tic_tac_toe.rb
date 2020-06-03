# A command line implementation of the classic game, using classes

class Game

  def initialize
    @current_player = ""
    @board = Board.new
  end

  def play_game
    get_first_player
    puts declare_winner(play_turns)
  end
 
  # get a valid first player from the user
  def get_first_player
    puts "Who is going first, X or O?"
    first_player = gets.chomp.upcase
    while first_player != "X" && first_player != "O"
      puts "Please enter X or O"
      first_player = gets.chomp.upcase
    end
    @current_player = first_player
  end
  
  # while the game is not over, play a turn:
  # display the board, get the current player's move, display the new board
  def play_turns
    counter = 0
    while (@board.game_winner != "X" && @board.game_winner != "O" && counter < 9)
      puts "It's #{@current_player}'s turn!"
      @board.display
      get_input(@current_player)
      @board.display
      @current_player == "X" ? @current_player = "O" : @current_player = "X"
      counter += 1
    end
    counter
  end

  # at the end of the game, display the game status (winner or "it's a tie")
  def declare_winner(counter)
    if counter == 9
      @board.game_winner == "no winner" ? "It's a tie!" : "#{@board.game_winner} wins!"
    else
      "#{@board.game_winner} wins!"
    end
  end
  
  # get a proper move from the current player, and store it in the board
  def get_input(user)
    puts "Select one of the available slots"
    input = gets.chomp.to_i
    while !input.between?(1,9)
      puts "Please enter an integer between 1 and 9"
      input = gets.chomp.to_i
    end
    while @board.occupied?(input)
      puts "Please enter an integer that has not been played yet"
      input = gets.chomp.to_i
    end
    @board.populate_square(user, input)
  end

end

class Board

  def initialize
    @grid = [1,2,3,4,5,6,7,8,9]
  end

  # check if a board square already has an X or an O
  def occupied?(input)
    @grid[input - 1] == "X" || @grid[input - 1] == "O"
  end

  # populate a board square
  def populate_square(user, input)
    @grid[input - 1] = user
  end

  # determine if there is a game winner and return that winner or "no winner"
  def game_winner
    if ((@grid[0] == @grid[1] && @grid[1] == @grid[2]) ||  # top row win
            (@grid[0] == @grid[3] && @grid[3] == @grid[6])) # left column win
      return @grid[0]
    elsif ((@grid[3] == @grid[4] && @grid[4] == @grid[5]) || # middle row win
            (@grid[1] == @grid[4] && @grid[4] == @grid[7]) || # middle column win
            (@grid[0] == @grid[4] && @grid[4] == @grid[8]) || # diagonal win
            (@grid[2] == @grid[4] && @grid[4] == @grid[6])) # diagonal win
      return @grid[4]
    elsif ((@grid[2] == @grid[5] && @grid[5] == @grid[8]) || # right column win
            (@grid[6] == @grid[7] && @grid[7] == @grid[8])) # bottom row win
      return @grid[8]
    else
      return "no winner"
    end
  end

  # display the board
  def display
    puts ""
    puts "                ||         ||"
    puts "                ||         ||"
    puts "           #{@grid[0]}    ||    #{@grid[1]}    ||    #{@grid[2]}"
    puts "                ||         ||"
    puts "       =========||=========||========="
    puts "                ||         ||"
    puts "           #{@grid[3]}    ||    #{@grid[4]}    ||    #{@grid[5]}"
    puts "                ||         ||"
    puts "       =========||=========||========="
    puts "                ||         ||"
    puts "                ||         ||"
    puts "           #{@grid[6]}    ||    #{@grid[7]}    ||    #{@grid[8]}"
    puts "                ||         ||"
    puts "                ||         ||"
    puts ""
  end
  
end

game = Game.new
game.play_game