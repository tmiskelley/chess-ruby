# frozen_string_literal: true

# represents chess board as a data structure,
# creates and contains reference to all square nodes and their data
class ChessBoard
  def initialize
    @squares = generate_squares
  end

  def generate_squares
    squares = []
    [*1..8, *'a'..'h']
      .repeated_permutation(2)
      .reject { |arr| arr[0].is_a?(Numeric) || arr.all?(String) }
      .sort { |arr1, arr2| arr2[1] <=> arr1[1] }
      .each { |arr| squares.push(Square.new(arr)) }
    squares
  end

  def display_board
    @squares.each_with_index do |square, i|
      print "|\n" if (i % 8).zero? && !i.zero?
      print "| #{square.coordinate.join} "
    end
    print "|\n"
  end
end

# represents an individual square on chess board
class Square
  attr_reader :coordinate

  def initialize(coordinate)
    @coordinate = coordinate
    @piece = nil # current piece on square
  end
end

ChessBoard.new.display_board
