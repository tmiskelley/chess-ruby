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
    white_player = Player.new('White', 'white')
    black_player = Player.new('Black', 'black')

    [white_player, black_player]
  end

  def place_pieces
    @players.each do |player|
      player.pieces.each do |_key, element|
        if element.is_a?(Array)
          element.each { |piece| @board.place_pieces(piece) }
        else
          @board.place_pieces(element)
        end
      end
    end
  end

  def player_move
    input = validate_input
    piece = input[0]
    coordinate = input[1]

    @board.move_piece(piece, coordinate)
    @current_player.move_piece(piece, coordinate)
  end

  def validate_input
    input = gets.chomp

    unless invalid_input?(input)
      coordinate = set_coordinate(input).split('')
      coordinate[1] = coordinate[1].to_i

      return select_piece(input, coordinate) if potential_move?(input, coordinate) && free_square?(input, coordinate)
    end

    input_error
  end

  def invalid_input?(input)
    input == '' || !@current_player.pieces.key?(input[0])
  end

  # sets the coordinates depending on whether the player entered pawn move
  def set_coordinate(input)
    input.size == 2 ? input[0..] : input[1..]
  end

  def potential_move?(input, coordinate)
    element = @current_player.pieces[input[0]]
  
    if double_piece?(input)
      element.each do |piece|
        piece.potential_moves.include?(coordinate)
      end
    else
      element.potential_moves.include?(coordinate)
    end
  end

  def double_piece?(input)
    # returns true if there are two of the same piece type in player hash
    @current_player.pieces[input[0]].is_a?(Array)
  end

  def free_square?(input, coordinate)
    # returns true as long as the selected square does not have a piece on it
    @board.find_square(coordinate.join).piece.nil?
  end

  def select_piece(input, coordinate)
    piece = @current_player.pieces[input[0]]

    if double_piece?(input)
      piece.each do |item|
        piece = item if item.potential_moves.include?(coordinate)
      end
    end

    piece.is_a?(Array) ? input_error : [piece, coordinate.join]
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
