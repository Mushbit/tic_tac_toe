require 'pry-byebug'
# Used to manage graph
class Graph
  def track_mark_placement
    @@rows = {
      a: ['O', 'O', ' '],
      b: [' ', ' ', ' '],
      c: [' ', ' ', ' ']
    }
  end

  def self.draw
    line_row = ' ___________'
    sandwich_row = '    |   |   '
    graph = "\n      1   2   3
    #{sandwich_row}
    A #{@@rows[:a].join(' | ')}
    #{line_row}
    #{sandwich_row}
    B #{@@rows[:b].join(' | ')}
    #{line_row}
    #{sandwich_row}
    c #{@@rows[:c].join(' | ')}
    \n"
    puts graph
  end

  def self.reset
    @@rows = {
      a: ['O', 'O', ' '],
      b: [' ', ' ', ' '],
      c: [' ', ' ', ' ']
    }
  end
end

# Super class for marking X's and O's
class Player < Graph
  attr_reader :name

  def initialize(name)
    super
    @name = name
  end

  def mark(row, column)
    @@rows[row.downcase.to_sym][column - 1] = @marking
    Graph.draw
    check_win
  end

  def check_win
    stats = [
      @@rows[:a],
      @@rows[:b],
      @@rows[:c],
      [@@rows[:a][0], @@rows[:b][0], @@rows[:c][0]],
      [@@rows[:a][1], @@rows[:b][1], @@rows[:c][1]],
      [@@rows[:a][2], @@rows[:b][2], @@rows[:c][2]],
      [@@rows[:a][0], @@rows[:b][1], @@rows[:c][2]],
      [@@rows[:c][0], @@rows[:b][1], @@rows[:a][2]]
    ]
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
