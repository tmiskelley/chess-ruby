# frozen_string_literal: true

require './lib/board'

# This class controls the overall functionality of the chess game, making
# all necessary changes and updates to the games state, and sending messages
# to update individual classes and object states
class GameManager
  def initialize
    @board = ChessBoard.new
  end

  def play
    @board.display_board
  end
end
