# frozen_string_literal: true

# class representing the white player and all associated pieces
class WhitePlayer
  attr_reader :name, :pieces

  def initialize
    @name = 'White'
    @pieces = [King.new("\u265A", 'e1')]
  end
end

# class representing the black player and all associated pieces
class BlackPlayer
  attr_reader :name, :pieces

  def initialize
    @name = 'Black'
    @pieces = [King.new("\u2654", 'e8')]
  end
end
