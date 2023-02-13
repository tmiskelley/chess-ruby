# frozen_string_literal: true

# represents chess pawn moveset and rules
class Pawn
  attr_accessor :current_pos
  attr_reader :symbol, :potential_moves

  def initialize(symbol, start_pos)
    @symbol = symbol
    @current_pos = start_pos
    @potential_moves = update_position
  end

  def move(coordinate)
    @current_pos = coordinate
    update_position
  end

  private

  def generate_moves(current_spot)
    current_spot[1] = current_spot[1].to_i

    @symbol == "\u265f" ? current_spot[1] += 1 : current_spot[1] -= 1
    [current_spot]
  end

  def update_position
    @potential_moves = generate_moves(@current_pos.split(''))
  end
end