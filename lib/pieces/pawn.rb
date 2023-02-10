# frozen_string_literal: true

# represents chess pawn moveset and rules
class Pawn
  def initialize(symbol, start_pos)
    @symbol = symbol
    @current_pos = start_pos
    @potential_moves = nil # generate pawn moves
  end
end