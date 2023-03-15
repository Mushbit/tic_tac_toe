require 'pry-byebug'
# Used to manage graph
class Graph
  attr_accessor :tiles

  def initialize
    @tiles = Array.new(3) { Array.new(3) { ' ' } }
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

  def count_mark_rows
    tiles.map { |v| v }
  end

  def count_mark_cols
    (0..2).map { |i| tiles.map { |v| v[i] } }
  end

  def count_mark_diag
    [0, 2].map do |y|
      case y
      when 0
        (0..2).map { |i| tiles[0 + i][y + i] }
      when 2
        (0..2).map { |i| tiles[0 + i][y - i] }
      end
    end
  end

  def stats
    count_mark_diag + count_mark_rows + count_mark_cols
  end

  def mark(row, column, marking)
    tiles[row - 1][column - 1] = marking
    draw
  end
end

# Super class for marking X's and O's and checking wins
class Player
  def initialize(name)
    @name = name
  end

  def choose_location(row, column)
    game.mark(row, column, @marking)
  end

  def check_win(stats)
    stats.map { |score| score.tally[@marking] == 3 }.any?(true)
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

# Will use this class to control pase and maintain rules of the game
class Game
  def initialize
    @game = Graph.new
    @player1 = Cross.new('John')
    @player2 = Circle.new('Frank')
  end
end


game = Graph.new
player1 = Cross.new('John')
player2 = Circle.new('Frank')
game.mark(1, 2, 'O')
p player1.check_win(game.stats)
game.mark(1, 1, 'X')
p player2.check_win(game.stats)
game.mark(1, 3, 'O')
p player1.check_win(game.stats)
game.mark(3, 1, 'X')
p player2.check_win(game.stats)
game.mark(3, 3, 'O')
p player1.check_win(game.stats)
game.mark(2, 2, 'X')
p player2.check_win(game.stats)
game.mark(2, 3, 'O')
p player2.check_win(game.stats)
p game.count_mark_diag
p game.count_mark_rows
p game.count_mark_cols
p game.stats
