# frozen_string_literal: true

require './lib/players'
require './lib/board'

# this class controls the overall functionality of the chess game, making
# all necessary changes and updates to the games state, and sending messages
# to update individual classes and object states
class GameManager
  def initialize
    @board = ChessBoard.new
    @players = create_players
    @current_player = @players[0]
    place_pieces
  end

  def play
    loop do
      @board.display_board
      print "\n#{@current_player.name}'s turn: "
      player_move
      switch_player
    end
  end

  private

  def create_players
    white_pieces = {
      'K' => King.new("\u265A", 'e1')
    }

    black_pieces = {
      'K' => King.new("\u2654", 'e8')
    }

    white_player = Player.new('White', white_pieces)
    black_player = Player.new('Black', black_pieces)

    [white_player, black_player]
  end

  def place_pieces
    @players.each do |player|
      player.pieces.each do |_key, piece|
        @board.place_king(piece)
      end
    end
  end

  def player_move
    input = validate_input
    @board.move_piece(@current_player.pieces[input[0]], input)
    @current_player.pieces[input[0]].move(input[1..])
  end

  def validate_input
    input = gets.chomp

    unless invalid_input?(input)
      coordinate = input[1..].split('')
      coordinate[1] = coordinate[1].to_i
      return input if potential_move?(input, coordinate) && not_king?(input, coordinate)
    end

    input_error
  end

  def invalid_input?(input)
    input == '' || input.size > 3 || !@current_player.pieces.key?(input[0])
  end

  def potential_move?(input, coordinate)
    @current_player.pieces[input[0]].potential_moves.any? { |arr| arr == coordinate }
  end

  def not_king?(input, coordinate)
    # returns true as long as the piece on chosen square is not the king
    !@board.find_square(coordinate.join).piece.is_a? King
  end

  def input_error
    print 'Entered move is invalid or illegal, please enter another move: '
    validate_input
  end

  def switch_player
    @current_player =
      @current_player == @players[0] ? @players[1] : @players[0]
  end
end
