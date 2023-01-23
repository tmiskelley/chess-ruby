# frozen_string_literal: true

# represents chess king moveset and rules
class King
  attr_accessor :current_pos
  attr_reader :symbol

  MOVES = [-1, 0, 1].repeated_permutation(2).to_a

  def initialize(symbol, start_pos)
    @symbol = symbol
    @current_pos = start_pos
    @potential_moves = generate_moves(@current_pos.split(''))
  end

  # generates all possible moves that the King can make
  def generate_moves(current_spot)
    current_spot[0] = current_spot[0].ord
    current_spot[1] = current_spot[1].to_i
    MOVES
      .map { |arr| [current_spot[0] + arr[0], current_spot[1] + arr[1]] }
      .select { |arr| arr[0].between?(97, 104) && arr[1].between?(1, 8) }
      .map { |arr| [arr[0].chr, arr[1]] }
      .reject { |arr| arr.join == @current_pos }
  end
end
