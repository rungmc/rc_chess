# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for rooks.
class Rook < Piece
  def moveset(board, row, col)
    moves = []
    # Evaluates each direction from the rook outward.
    moves + right(board, row, col) + left(board, row, col) +
      up(board, row, col) + down(board, row, col)
  end
end
