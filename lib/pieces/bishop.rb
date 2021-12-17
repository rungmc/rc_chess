# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for bishops.
class Bishop < Piece
  def moveset(board, row, col)
    moves = []
    # Evaluates each direction from the bishop outward.
    moves + right_up(board, row, col) + right_down(board, row, col) +
      left_up(board, row, col) + left_down(board, row, col)
  end
end
