# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for knights.
class Knight < Piece
  KNIGHT_MOVES = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]].freeze

  def moveset(board, row, col)
    moves = []
    moves + teleport(KNIGHT_MOVES, board, row, col)
  end
end
