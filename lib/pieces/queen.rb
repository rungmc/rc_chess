# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for queens.
class Queen < Piece
  def moveset(board, row, col)
    moves = []
    # Evaluates each direction from the bishop outward.
    moves + right(board, row, col) + left(board, row, col) +
      up(board, row, col) + down(board, row, col) +
      right_up(board, row, col) + right_down(board, row, col) +
      left_up(board, row, col) + left_down(board, row, col)
  end
end
