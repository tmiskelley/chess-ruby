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

  def valid_square?(coordinate)
    coordinate[0].between?(97, 104) && coordinate[1].between?(1, 8)
  end
end

# represents chess king moveset and rules
class King < GamePiece
  MOVES = [-1, 0, 1].repeated_permutation(2).to_a

  # generates all possible moves that the King can make
  def generate_moves(current_spot)
    current_spot = [current_spot[0].ord, current_spot[1].to_i]

    MOVES
      .map { |arr| [current_spot[0] + arr[0], current_spot[1] + arr[1]] }
      .select { |arr| arr[0].between?(97, 104) && arr[1].between?(1, 8) }
      .map { |arr| [arr[0].chr, arr[1]] }
      .reject { |arr| arr.join == @current_pos }
  end
end

# represents chess queen moveset and rules
class Queen < GamePiece
  MOVESET_1 = [-1, 0, 1].repeated_permutation(2).to_a
  MOVESET_2 = [[-1, 0], [0, -1], [0, 1], [1, 0]]
  MOVESET_3 = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

  def generate_moves(current_spot)
    current_spot = [current_spot[0].ord, current_spot[1].to_i]
    queen_moves = []

    king_moves(current_spot.dup).each { |arr| queen_moves.push(arr) }
    rook_and_bishop(current_spot.dup, MOVESET_2).each { |arr| queen_moves.push(arr) }
    rook_and_bishop(current_spot.dup, MOVESET_3).each { |arr| queen_moves.push(arr) }

    queen_moves
  end

  def king_moves(current_spot)
    MOVESET_1
      .map { |arr| [current_spot[0] + arr[0], current_spot[1] + arr[1]] }
      .select { |arr| arr[0].between?(97, 104) && arr[1].between?(1, 8) }
      .map { |arr| [arr[0].chr, arr[1]] }
      .reject { |arr| arr.join == @current_pos }
  end

  def rook_and_bishop(current_spot, moveset)
    moves = []

    moveset.each do |transform|
      spot = current_spot.dup
      until !valid_square?(spot)
        spot = [spot[0] + transform[0], spot[1] + transform[1]]
        moves.push(spot) if valid_square?(spot)
      end
    end

    moves.map { |arr| [arr[0].chr, arr[1]] }
  end
end

# represents chess rook moveset and rules
class Rook  < GamePiece
  MOVES = [
    [-1, 0], [0, -1], [0, 1], [1, 0]
  ]

  def generate_moves(current_spot)
    current_spot = [current_spot[0].ord, current_spot[1].to_i]
    rook_moves = []

    MOVES.each do |transform|
      spot = current_spot.dup
      until !valid_square?(spot)
        spot = [spot[0] + transform[0], spot[1] + transform[1]]
        rook_moves.push(spot) if valid_square?(spot)
      end
    end

    rook_moves.map { |arr| [arr[0].chr, arr[1]] }
  end
end

# represents chess bishop moveset and rules
class Bishop < GamePiece
  MOVES = [
    [-1, -1], [-1, 1], [1, -1], [1, 1]
  ]

  def generate_moves(current_spot)
    current_spot = [current_spot[0].ord, current_spot[1].to_i]
    bishop_moves = []

    MOVES.each do |transform|
      spot = current_spot.dup
      until !valid_square?(spot)
        spot = [spot[0] + transform[0], spot[1] + transform[1]]
        bishop_moves.push(spot) if valid_square?(spot)
      end
    end

    bishop_moves.map { |arr| [arr[0].chr, arr[1]] }
  end
end

# represents chess knight moveset and rules
class Knight < GamePiece
  MOVES = [
    [-2, -1], [-2, 1], [-1, -2], [-1, 2],
    [1, -2], [1, 2], [2, -1], [2, 1]
  ]

  def generate_moves(current_spot)
    current_spot = [current_spot[0].ord, current_spot[1].to_i]

    MOVES
      .map { |arr| [current_spot[0] + arr[0], current_spot[1] + arr[1]] }
      .select { |arr| arr[0].between?(97, 104) && arr[1].between?(1, 8) }
      .map { |arr| [arr[0].chr, arr[1]] }
  end
end

# represents chess pawn moveset and rules
class Pawn < GamePiece
  def generate_moves(current_spot)
    moves = []
    current_spot[1] = current_spot[1].to_i

    @symbol == "\u2659" ? current_spot[1] += 1 : current_spot[1] -= 1
    moves.push(current_spot)

    if first_move?(current_spot)
      double_move = current_spot.dup

      @symbol == "\u2659" ? double_move[1] += 1 : double_move[1] -= 1
      moves.push(double_move)
    end

    moves
  end

  def first_move?(current_spot)
    @symbol == "\u2659" ? current_spot[1] == 3 : current_spot[1] == 6
  end
end
