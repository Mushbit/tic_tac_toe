require 'pry-byebug'
# Used to manage graph
class Graph
  attr_accessor :tiles

  def initialize
    @tiles = Array.new(3) { Array.new(3, ' ') }
  end

  def draw
    line_row = ' ---+---+---'
    board = "\n      1   2   3
    A #{tiles[0].join(' | ')}
    #{line_row}
    B #{tiles[1].join(' | ')}
    #{line_row}
    c #{tiles[2].join(' | ')}
    \n"
    puts board
  end

  def check_horizontal_score
    tiles.map { |v| v }
  end

  def check_vertical_score
    (0..2).map { |i| tiles.map { |v| v[i] } }
  end

  def check_diagonal_score
    [0, 2].map do |y|
      case y
      when 0
        (0..2).map { |i| tiles[0 + i][y + i] }
      when 2
        (0..2).map { |i| tiles[0 + i][y - i] }
      end
    end
  end

  def mark(row, column, marking)
    tiles[row - 1][column - 1] = marking
    draw
  end
end

# Super class for marking X's and O's
class Player
  def initialize(name)
    @name = name
  end

  def choose_location(row, column)
    game.mark(row, column, @marking)
  end

  def check_win
    stats.each do |score|
      break unless score.tally[@marking] == 3

      puts "--- #{@name} wins this round! ---"
      @wins += 1

      puts "--- #{@name} won the game! ---" if @wins == 3
    end
  end
end

# Player "O"
class Circle < Player
  def initialize(name = 'O')
    super
    @marking = 'O'
    @wins = 0
  end
end

# Player "X"
class Cross < Player
  def initialize(name = 'X')
    super
    @marking = 'X'
    @wins = 0
  end
end

game = Graph.new
player1 = Cross.new('John')
player2 = Circle.new('Frank')
game.mark(1, 1, 'X')
game.mark(3, 1, 'X')
game.mark(2, 2, 'X')
game.mark(1, 2, 'O')
game.mark(1, 3, 'O')
game.mark(3, 3, 'O')
p game.check_diagonal_score
p game.check_horizontal_score
p game.check_vertical_score
