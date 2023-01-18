# frozen_string_literal: true

# represents chess king moveset and rules
class King
  attr_accessor :current_pos
  attr_reader :symbol, :start_pos

  def initialize(symbol, start_pos)
    @symbol = symbol
    @start_pos = start_pos
    @current_pos = nil
  end
end
