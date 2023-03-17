# frozen_string_literal: true

# responsible for managing the game board, storing and displaying the state of the board, and checking for winning
# combinations.
class TicTacToeBoard
  attr_accessor :board_state

  def initialize
    @board_state = Array.new(3) { Array.new(3) { ' ' } }
  end

  def draw
    horizontal_line = ' ---+---+---'
    board_string = "\n      1   2   3
    A #{board_state[0].join(' | ')}
    #{horizontal_line}
    B #{board_state[1].join(' | ')}
    #{horizontal_line}
    c #{board_state[2].join(' | ')}
    \n"
    puts board_string
  end

  def count_mark_rows
    board_state.map { |v| v }
  end

  def count_mark_cols
    (0..2).map { |i| board_state.map { |v| v[i] } }
  end

  def count_mark_diag
    [0, 2].map do |y|
      case y
      when 0
        (0..2).map { |i| board_state[0 + i][y + i] }
      when 2
        (0..2).map { |i| board_state[0 + i][y - i] }
      end
    end
  end

  def stats
    count_mark_diag + count_mark_rows + count_mark_cols
  end

  def mark(row, column, marker)
    board_state[row - 1][column - 1] = marker
    draw
  end

  def occupied?(row, column)
    board_state[row - 1][column - 1].match?(/[XO]/)
  end

  def all_occupied?
    board_state.map { |v| v.none?(' ') }.all?(true)
  end
end

# An abstract class that serves as a template for creating player objects
class TicTacToePlayer
  attr_accessor :num_turns, :num_wins, :marker
  attr_reader :name

  def initialize(name)
    @name = name
    @num_turns = 0
    @num_wins = 0
  end
end

# Player "O"
class TicTacToeCirclePlayer < TicTacToePlayer
  def initialize(name = 'O')
    super
    @marker = 'O'
  end
end

# Player "X"
class TicTacToeCrossPlayer < TicTacToePlayer
  def initialize(name = 'X')
    super
    @marker = 'X'
  end
end

# Will use this class to control pase and maintain rules of the board
class TicTacToeGame
  attr_accessor :board, :player1, :player2

  def initialize
    puts 'Player 1 name:'
    name1 = gets.chomp
    puts 'Player 2 name:'
    name2 = gets.chomp
    @player1 = TicTacToeCrossPlayer.new(name1)
    @player2 = TicTacToeCirclePlayer.new(name2)
    @board = TicTacToeBoard.new
  end

  def display_instructions
    board.draw
    puts "When choosing a tile to mark use coordinates like: B 1 -or- b1.
    \n"
    switch_player
  end

  def switch_player
    player = player1.num_turns <= player2.num_turns ? player1 : player2

    play_round(player)
  end

  # rubocop:disable Metrics/AbcSize(RuboCop)
  # rubocop:disable Metrics/MethodLength
  def play_round(player)
    coordinates = gets_coordinates(player)

    if board.occupied?(coordinates[0], coordinates[1])
      puts 'This tile is already occupied.'
      switch_player
    else
      board.mark(coordinates[0], coordinates[1], player.marker)
    end

    announce_result(player) if win?(board.stats, player)

    player.num_turns += 1

    if board.all_occupied?
      game_tied
    elsif player.num_wins < 3
      switch_player
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize(RuboCop)

  def gets_coordinates(player)
    puts "It is #{player.name}'s turn:"

    convert_x(gets.chomp.split(''))
  end

  def convert_x(coordinates)
    coordinates.delete(' ')

    display_instructions unless coordinates[1].to_i.between?(1, 3)

    result = [coordinates[1].to_i]

    result.unshift(case coordinates[0].downcase
                   when 'a' then 1
                   when 'b' then 2
                   when 'c' then 3
                   else
                     display_instructions
                   end)
  end

  def win?(stats, player)
    stats.map { |score| score.tally[player.marker] == 3 }.any?(true)
  end

  def game_tied
    puts 'This round ends in a tie.'
    @board = TicTacToeBoard.new
    board.draw
  end

  # rubocop:disable Metrics/AbcSize(RuboCop)
  def announce_result(player)
    player.num_wins += 1

    puts player.num_wins >= 3 ? "#{player.name} won the game!\n" : "#{player.name} just won the round!\n"

    puts "The score is #{player1.name} : #{player1.num_wins} vs #{player2.name} : #{player2.num_wins}"

    @board = TicTacToeBoard.new
    board.draw
  end
end
# rubocop:enable Metrics/AbcSize(RuboCop)

def launch
  loop do
    case gets.chomp.downcase
    when 'y'
      play = TicTacToeGame.new
      play.display_instructions
    when 'n' then break
    end
    puts 'Want to try again? y/n'
  end
end

puts 'Do you want to play some tic-tac toe? y/n'
launch
