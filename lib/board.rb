# frozen_string_literal: true

require './lib/pieces/king'

# represents chess board as a data structure,
# creates and contains reference to all square nodes and their data
class ChessBoard
  def initialize
    @squares = generate_squares
    place_kings
  end

  def display_board
    @squares.each_with_index do |square, i|
      print "|\n" if (i % 8).zero? && !i.zero?
      print square.piece.nil? ? '|   ' : "| #{square.piece.symbol} "
      # remember to update piece printing to unicode symbol
    end
    print "|\n"
  end

  private

  def generate_squares
    squares = []
    [*1..8, *'a'..'h']
      .repeated_permutation(2)
      .reject { |arr| arr[0].is_a?(Numeric) || arr.all?(String) }
      .sort { |arr1, arr2| arr2[1] <=> arr1[1] }
      .each { |arr| squares.push(Square.new(arr.join)) }
    squares
  end

  def find_square(coordinate)
    @squares.each { |square| return square if coordinate == square.coordinate }
    raise "square '#{coordinate}' does not exist."
  end

  def place_kings
    white_king_start = find_square('e1')
    black_king_start = find_square('e8')

    white_king_start.piece = King.new("\u265A", white_king_start)
    black_king_start.piece = King.new("\u2654", black_king_start)
  end
end

# represents an individual square on chess board
class Square
  attr_accessor :piece
  attr_reader :coordinate

  def initialize(coordinate)
    @coordinate = coordinate
    @piece = nil # current piece on square
  end
end
