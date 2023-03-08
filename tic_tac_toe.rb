require 'pry-byebug'
# Used to manage graph
class Graph
  @@rows = {
    a: [' ', ' ', ' '],
    b: [' ', ' ', ' '],
    c: [' ', ' ', ' ']
  }
  @@stats = [
    @@rows[:a],
    @@rows[:b],
    @@rows[:c],
    [@@rows[:a][0], @@rows[:b][0], @@rows[:c][0]],
    [@@rows[:a][1], @@rows[:b][1], @@rows[:c][1]],
    [@@rows[:a][2], @@rows[:b][2], @@rows[:c][2]],
    [@@rows[:a][0], @@rows[:b][1], @@rows[:c][2]],
    [@@rows[:c][0], @@rows[:b][1], @@rows[:a][2]]
  ]

  def self.rows
    @@stats
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

  def self.update_mark_placement
  end

  def self.check_win
    @@stats.each do |score|
      case
      when score.tally['X'] == 3
        puts '--- X wins this round! ---'
      when score.tally['O'] == 3
        puts '--- O wins this round! ---'
      end
    end
  end
end

# Super class for marking behavior
class Piece < Graph
  def mark(row, column)
    @@rows[row.downcase.to_sym][column - 1] = @marking
    Graph.draw
    Graph.check_win
  end
end

# Player class
class Circle < Piece
  def initialize
    super
    @marking = 'O'
  end
end

# Player class
class Cross < Piece
  def initialize
    super
    @marking = 'X'
  end
end
