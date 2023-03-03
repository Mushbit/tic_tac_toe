# Used to manage graph
class Graph
  LINE_ROW = '____________'
  SANDWICH_ROW = '   |   |   '
  @rowes = {
    sandwich_row1: SANDWICH_ROW,
    a: [' ', 'X', ' '],
    line_row2: LINE_ROW,
    sandwich_row2: SANDWICH_ROW,
    b: [' ', ' ', ' '],
    line_row3: LINE_ROW,
    sandwich_row3: SANDWICH_ROW,
    c: [' ', ' ', ' ']
  }

  def self.draw
    @rowes.each do |key, row|
      graph = ''

      graph += if key.match(/line/) || key.match(/sandwich/)
                 row
               else
                 " #{row[0]} | #{row[1]} | #{row[2]} "
               end
      puts graph
    end
  end
end

# Super class for marking behaviour
class Piece
end

# Player class
class Circle < Piece
end

# Player class
class Cross < Piece
end
