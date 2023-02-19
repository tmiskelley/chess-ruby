# frozen_string_literal: true

# represts game piece parent class
class GamePiece
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

  def update_position
    @potential_moves = generate_moves(@current_pos.split(''))
  end
end

# represents chess king moveset and rules
class King < GamePiece
  MOVES = [-1, 0, 1].repeated_permutation(2).to_a

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

# represents chess pawn moveset and rules
class Pawn < GamePiece
  def generate_moves(current_spot)
    moves = []
    current_spot[1] = current_spot[1].to_i

    @symbol == "\u265f" ? current_spot[1] += 1 : current_spot[1] -= 1
    moves.push(current_spot)

    if first_move?(current_spot)
      double_move = current_spot.dup

      @symbol == "\u265f" ? double_move[1] += 1 : double_move[1] -= 1
      moves.push(double_move)
    end

    moves
  end

  def first_move?(current_spot)
    @symbol == "\u265f" ? current_spot[1] == 3 : current_spot[1] == 6
  end
end
