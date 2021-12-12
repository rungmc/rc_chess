# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for pawns.
class Pawn < Piece
  attr_reader :moves

  def available_moves
    moves = []
    # Moves forward one space if free
    moves << [x, y + 1] if board.grid[x][y + 1].nil?
    # Moves forward two spaces if first move and free
    moves << [x, y + 2] unless board.grid[x][y + 2].nil? && moved?
    # Moves diagonally if occupied by enemy
  end
end
