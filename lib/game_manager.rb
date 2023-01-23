# frozen_string_literal: true

require './lib/players'
require './lib/board'

# this class controls the overall functionality of the chess game, making
# all necessary changes and updates to the games state, and sending messages
# to update individual classes and object states
class GameManager
  def initialize
    @board = ChessBoard.new
    @players = [WhitePlayer.new, BlackPlayer.new]
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

  def place_pieces
    @players.each do |player|
      player.pieces.each do |piece|
        @board.place_king(piece)
      end
    end
  end

  def player_move
    input = gets.chomp
    @board.move_piece(@current_player.pieces[0], input)
    @current_player.pieces[0].current_pos = input[1..]
  end

  def switch_player
    @current_player =
      @current_player == @players[0] ? @players[1] : @players[0]
  end
end
