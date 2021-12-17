# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for kings.
class King < Piece
  KING_MOVES = [[-1, 1], [0, 1], [1, 1], [1, 0], [-1, 0], [-1, -1], [0, -1], [1, -1]].freeze

  def moveset(board, row, col)
    moves = []
    KING_MOVES.each do |i|
      next_pos = board[i[0] + row][i[1] + col]
      moves << [i[0] + row, i[1] + col] unless next_pos.team == @team
    end
    moves += castling(board, col)
    moves
  end

  private

  # Castling - must be first move for both king & rook, no spaces occupied between them.
  # Returns the coordinates of eligible rooks for handling by game.
  def castling(board, col)
    moves = []
    return moves if moved?

    # King side castle.
    moves += [7, col] if !board[7][col].moved? && check_empty(5..6, col)
    # Queen side castle.
    moves += [0, col] if !board[0][col].moved? && check_empty(1..3, col)
    moves
  end

  def check_empty(row_range, col)
    board[row_range].all? { |i| i[col].nil? }
  end
end
