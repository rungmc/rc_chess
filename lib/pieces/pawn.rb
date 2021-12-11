# frozen_string_literal: true

require_relative 'chess_piece'
# Basic state and moveset for pawns.
class Pawn < ChessPiece
  def moves
    proc do |x, y|
      moves = []
      moves << [x, y + 1] if [x, y + 1].nil?
      moves << [x, y + 2] unless moved?
    end
  end
end
