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
  attr_accessor :turns, :wins
  attr_reader :name

  def initialize(name)
    @name = name
    @turns = 0
    @wins = 0
  end
end

# Player "O"
class Circle < Player
  def initialize(name = 'O')
    super
    @marking = 'O'
  end
end

# Player "X"
class Cross < Player
  attr_reader :marking

  def initialize(name = 'X')
    super
    @marking = 'X'
  end
end

# Will use this class to control pase and maintain rules of the game
class Game
  attr_accessor :game, :player1, :player2

  def initialize
    @game = Graph.new
    # puts 'Player 1 name:'
    # name1 = gets.chomp
    # puts 'Player 2 name:'
    # name2 = gets.chomp
    @player1 = Cross.new('Frank')
    @player2 = Circle.new('Tyrone')
    switch_player
  end

  def start_game
    game.draw
    puts 'When choosing a tile to mark use coordinates like so: B 1 -or- A 3.
    Remember to leave a white space between the x and y coordinate.'
    switch_player
  end

  def switch_player
    player = if player1.turns >= player2.turns
               player1
             else
               player2
             end
    play_round(player)
  end

  def convert_x(x_y)
    case x_y[0].downcase
    when 'a'
      x_y[0] = 3
    when 'b'
      x_y[0] = 2
    when 'c'
      x_y[0] = 1
    else
      start_game
    end
  end

  def play_round(player)
    puts "It is #{player.name}'s turn:"
    x_y = convert_x(gets.chomp.split)
    game.mark(x_y[0], x_y[1], player.marking)
    celebrate(player) if check_win(game.stats, player)
    player.turns += 1
    switch_player unless player.wins == 3
  end

  def check_win(stats, player)
    stats.map { |score| score.tally[player.marking] == 3 }.any?(true)
  end

  def celebrate(player)
    player.wins += 1
    if player.wins == 3
      puts "#{player} won the game!"
    end
    "#{player} just won this round!"
  end
end
