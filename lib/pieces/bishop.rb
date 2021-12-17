# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for bishops.
class Bishop < Piece
  def moveset(board, row, col)
    moves = []
    moves += forward_right(board, row, col)
    moves += forward_left(board, row, col)
    moves += backward_right(board, row, col)
    moves += backward_left(board, row, col)
  end

  def forward_right(board, row, col)
    ((row + 1)..7).each do
  end

  def forward_left(board, row, col)
  end

  def backward_right(board, row, col)
  end

  def backward_left(board, row, col)
  end
end
