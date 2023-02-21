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
    @pieces[piece].move(coordinate)
  end

  def instantiate_pieces
    @pieces =
      @color == 'white' ? instantiate_white_pieces : instantiate_black_pieces
  end

  def instantiate_white_pieces
    {
      'K' => King.new("\u265A", 'e1'),
      'N' => [Knight.new("\u265e", 'b1'), Knight.new("\u265e", 'g1')],
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
      'N' => [Knight.new("\u2658", 'b8'), Knight.new("\u2658", 'g8')],
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
end
