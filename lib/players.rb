# frozen_string_literal: true

# class representing the player and their associated pieces
class Player
  attr_reader :name, :pieces

  def initialize(name, pieces)
    @name = name
    @pieces = pieces
  end
end
