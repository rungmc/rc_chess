# frozen_string_literal: true

# Generic chess piece class.
class Piece
  attr_reader :team, :symbol
  attr_accessor :moved
  alias moved? moved

  def initialize(team, symbol, moved: false)
    @team = team
    @symbol = symbol
    @moved = moved
  end
end
