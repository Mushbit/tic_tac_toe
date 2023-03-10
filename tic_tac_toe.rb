require 'pry-byebug'
# Used to manage graph
class Graph
  attr_accessor :rows

  def initialize
    @rows = {
      a: [' ', ' ', ' '],
      b: ['X', ' ', 'O'],
      c: [' ', 'X', 'X']
    }
  end

  def draw
    line_row = ' ___________'
    sandwich_row = '    |   |   '
    graph = "\n      1   2   3
    #{sandwich_row}
    A #{rows[:a].join(' | ')}
    #{line_row}
    #{sandwich_row}
    B #{rows[:b].join(' | ')}
    #{line_row}
    #{sandwich_row}
    c #{rows[:c].join(' | ')}
    \n"
    puts graph
  end
end

# Super class for marking X's and O's
class Player
  def initialize(name)
    @name = name
  end

  def mark(row, column)
    game.rows[row.downcase.to_sym][column - 1] = @marking
    Graph.draw
    check_win
  end

  def get_stats
    abc = [:a, :b, :c]
    stats = [
      game.rows.map { |_k, v| v },
      (0..2).map { |i| rows.map { |_k, v| v[i] } },
      [game.rows[:a][0], game.rows[:b][1], game.rows[:c][2]],
      [game.rows[:c][0], game.rows[:b][1], game.rows[:a][2]]
    ]
  end

  def check_win
    stats.each do |score|
      break unless score.tally[@marking] == 3

      puts "--- #{@name} wins this round! ---"
      @wins += 1

      puts "--- #{@name} won the game! ---" if @wins == 3
      Graph.reset
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
