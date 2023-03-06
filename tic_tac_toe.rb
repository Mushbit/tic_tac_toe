require 'pry-byebug'
# Used to manage graph
class Graph
  LINE_ROW = ' ___________'
  SANDWICH_ROW = '    |   |   '
  @@rows = {
    x: '  1   2   3 ',
    sandwich_row1: SANDWICH_ROW,
    a: ['A', 'X', 'X', 'X'],
    line_row2: LINE_ROW,
    sandwich_row2: SANDWICH_ROW,
    b: ['B', 'X', 'O', 'O'],
    line_row3: LINE_ROW,
    sandwich_row3: SANDWICH_ROW,
    c: ['C', ' ', ' ', ' ']
  }

  def self.draw
    @@rows.each do |key, row|
      graph = ''

      graph += if key.match(/^a|^b|^c/m)
                 "#{row[0]} #{row[1]} | #{row[2]} | #{row[3]} "
               else
                 row
               end
      puts graph
    end
  end

  def self.check_win_condition
    @@rows.each do |key, row|
      next if key.match(/^x|sandwich_row|line_row/)

      # Checks horizontal condition to win, being 3 in a row
      if row.tally['X'] === 3
        puts '--- X wins! ---'
      elsif row.tally['O'] === 3
        puts '--- O wins! ---'
      end
    end
  end
end

# Super class for marking behavior
class Piece < Graph
  def mark(row, column)
    @@rows[row.to_sym][column] = @marking
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
