# frozen_string_literal: true

# class representing the player and their associated pieces
class Player
  attr_reader :name, :pieces

  def initialize(name, color)
    @name = name
    @color = color
    @pieces = instantiate_pieces
  end

  def move_piece(piece, coordinate)
    piece.move(coordinate)
  end

  def instantiate_pieces
    @pieces =
      @color == 'white' ? instantiate_white_pieces : instantiate_black_pieces
  end

  def instantiate_white_pieces
    {
      'K' => King.new("\u2654", 'e1'),
      'R' => [Rook.new("\u2656", 'a1'), Rook.new("\u2656", 'h1')],
      'N' => [Knight.new("\u2658", 'b1'), Knight.new("\u2658", 'g1')],
      'a' => Pawn.new("\u2659", 'a2'),
      'b' => Pawn.new("\u2659", 'b2'),
      'c' => Pawn.new("\u2659", 'c2'),
      'd' => Pawn.new("\u2659", 'd2'),
      'e' => Pawn.new("\u2659", 'e2'),
      'f' => Pawn.new("\u2659", 'f2'),
      'g' => Pawn.new("\u2659", 'g2'),
      'h' => Pawn.new("\u2659", 'h2')
    }
  end

  def instantiate_black_pieces
    {
      'K' => King.new("\u265a", 'e8'),
      'R' => [Rook.new("\u265c", 'a8'), Rook.new("\u265c", 'h8')],
      'N' => [Knight.new("\u265e", 'b8'), Knight.new("\u265e", 'g8')],
      'a' => Pawn.new("\u265f", 'a7'),
      'b' => Pawn.new("\u265f", 'b7'),
      'c' => Pawn.new("\u265f", 'c7'),
      'd' => Pawn.new("\u265f", 'd7'),
      'e' => Pawn.new("\u265f", 'e7'),
      'f' => Pawn.new("\u265f", 'f7'),
      'g' => Pawn.new("\u265f", 'g7'),
      'h' => Pawn.new("\u265f", 'h7')
    }
  end
end
