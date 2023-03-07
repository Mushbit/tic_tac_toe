require 'pry-byebug'
# Used to manage graph
class Graph
  @@rows = {
    a: [' ', ' ', ' '],
    b: [' ', ' ', ' '],
    c: [' ', ' ', ' '],
    one: [' ', ' ', ' '],
    two: [' ', ' ', ' '],
    three: [' ', ' ', ' '],
    tr_to_bl: [' ', ' ', ' '],
    tl_to_br: [' ', ' ', ' ']
  }

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

  def self.check_win_condition
    @@rows.each do |key, row|
      next if key.match(/^x|sandwich_row|line_row/)

      case
      when row.tally['X'] == 3
        puts '--- X wins this round! ---'
      when row.tally['O'] == 3
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
