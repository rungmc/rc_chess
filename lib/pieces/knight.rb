# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for knights.
class Knight < Piece
  KNIGHT_MOVES = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [-2, -1]].freeze

  def moveset(board, row, col)
    moves = []
    KNIGHT_MOVES.each do |i|
      next_pos = board[i[0] + row][i[1] + col]
      moves << [i[0] + row, i[1] + col] unless next_pos.team == @team
    end
    moves
  end
end
