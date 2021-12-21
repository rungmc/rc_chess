# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for kings.
class King < Piece
  KING_MOVES = [[-1, 1], [0, 1], [1, 1], [1, 0], [-1, 0], [-1, -1], [0, -1], [1, -1]].freeze

  def moveset(board, row, col)
    moves = []
    moves += teleport(KING_MOVES, board, row, col)
    moves + castling(board, col)
  end

  private

  # Castling - must be first move for both king & rook, no spaces occupied between them.
  # Returns the coordinates of eligible rooks for handling by game.
  def castling(board, col)
    moves = []
    return moves if moved?

    # King side castle.
    moves << [7, col] if verify_rook(board[7][col]) && check_path(board, 5..6, col)
    # Queen side castle.
    moves << [0, col] if verify_rook(board[0][col]) && check_path(board, 1..3, col)
    moves
  end

  def verify_rook(square)
    square.is_a?(Rook) && square.team == team && !square.moved?
  end

  def check_path(board, row_range, col)
    board[row_range].all? { |i| i[col].nil? }
  end
end
