# A command line implementation of the classic game, using classes

class Game

  def initialize
    @current_player = ""
    @board = Board.new
  end

  def play_game
    initial_state
    puts play_turn
  end
 
  def initial_state
    puts "Who is going first, X or O?"
    first_player = gets.chomp.upcase
    while first_player != "X" && first_player != "O"
      puts "Please enter X or O"
      first_player = gets.chomp.upcase
    end
    @current_player = first_player
  end
  
  def get_input(user)
    puts "Select one of the available slots"
    input = gets.chomp.to_i
    while !input.between?(1,9)
      puts "Please enter an integer between 1 and 9"
      input = gets.chomp.to_i
    end
    while @board.occupied?
      puts "Please enter an integer that has not been played yet"
      input = gets.chomp.to_i
    end
    @board.populate_square(user, input)
  end
  
  def play_turn
    counter = 0
    while (@board.game_winner != "X" && @board.game_winner != "O" && counter < 9)
      puts "It's #{@current_player}'s turn!"
      display
      current_grid = get_input(@current_player)
      display
      @current_player == "X" ? @current_player = "O" : @current_player = "X"
      counter += 1
    end
    if counter == 9
      if @board.game_winner == "no winner"
        return "It's a tie!"
      else
        return "#{@board.game_winner} wins!"
      end
    else
      return "#{@board.game_winner} wins!"
    end
  end
  
end

class Board

  def initialize
    @grid = [1,2,3,4,5,6,7,8,9]
  end

  def occupied?

  end

  def populate_square(user, input)
    @grid[input - 1] = user
    @grid
  end

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