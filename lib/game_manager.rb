# frozen_string_literal: true

require './lib/players'
require './lib/board'
require './lib/pieces'

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
    white_player = Player.new('White', instantiate_white_pieces)
    black_player = Player.new('Black', instantiate_black_pieces)

    [white_player, black_player]
  end

  def instantiate_white_pieces
    {
      'K' => King.new("\u265A", 'e1'),
      'a' => Pawn.new("\u265f", 'a2'),
      'b' => Pawn.new("\u265f", 'b2'),
      'c' => Pawn.new("\u265f", 'c2'),
      'd' => Pawn.new("\u265f", 'd2'),
      'e' => Pawn.new("\u265f", 'e2'),
      'f' => Pawn.new("\u265f", 'f2'),
      'g' => Pawn.new("\u265f", 'g2'),
      'h' => Pawn.new("\u265f", 'h2')
    }
  end

  def instantiate_black_pieces
    {
      'K' => King.new("\u2654", 'e8'),
      'a' => Pawn.new("\u2659", 'a7'),
      'b' => Pawn.new("\u2659", 'b7'),
      'c' => Pawn.new("\u2659", 'c7'),
      'd' => Pawn.new("\u2659", 'd7'),
      'e' => Pawn.new("\u2659", 'e7'),
      'f' => Pawn.new("\u2659", 'f7'),
      'g' => Pawn.new("\u2659", 'g7'),
      'h' => Pawn.new("\u2659", 'h7')
    }
  end

  def place_pieces
    @players.each do |player|
      player.pieces.each do |_key, piece|
        @board.place_pieces(piece)
      end
    end
  end

  def player_move
    input = validate_input
    coordinate = set_coordinate(input).join

    @board.move_piece(@current_player.pieces[input[0]], coordinate)
    @current_player.move_piece(input[0], coordinate)
  end

  def validate_input
    input = gets.chomp

    unless invalid_input?(input)
      coordinate = set_coordinate(input)
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

  def set_coordinate(input)
    input.size == 2 ? input[0..].split('') : input[1..].split('')
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
