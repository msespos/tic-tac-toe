# A command line implementation of the classic game

@grid = [1,2,3,4,5,6,7,8,9]

def get_input(user)
    puts "Select one of the available slots"
    input = gets.chomp.to_i
    if user == "X"
      @grid[input - 1] = "X"
    else
      @grid[input - 1] = "O"
    end
    p @grid
  end

def display(grid)
  puts ""
  puts "                ||         ||"
  puts "                ||         ||"
  puts "           #{grid[0]}    ||    #{grid[1]}    ||    #{grid[2]}"
  puts "                ||         ||"
  puts "       =========||=========||========="
  puts "                ||         ||"
  puts "           #{grid[3]}    ||    #{grid[4]}    ||    #{grid[5]}"
  puts "                ||         ||"
  puts "       =========||=========||========="
  puts "                ||         ||"
  puts "                ||         ||"
  puts "           #{grid[6]}    ||    #{grid[7]}    ||    #{grid[8]}"
  puts "                ||         ||"
  puts "                ||         ||"
  puts ""
end

get_input("X")
display(@grid)