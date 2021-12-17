# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for pawns.
class Pawn < Piece
  def moveset(board, row, col)
    moves = []
    moves << standard(board, row, col)
    moves << opening_double(board, row, col)
    moves += capture(board, row, col)
    moves
  end

  private

  # Flips direction of moves to be -y if black piece.
  def team_mod(val)
    return val if team == 'white'

    val * -1
  end

  # Moves forward one space if free
  def standard(board, row, col)
    y_displace = team_mod(1)
    return unless board[row][col + y_displace].nil?

    [row, col + y_displace]
  end

  # Moves forward two spaces if first move and free
  def opening_double(board, row, col)
    y_displace = team_mod(2)
    return unless board[row][col + y_displace].nil? && !moved?

    [row, col + y_displace]
  end

  # Captures diagonally.
  def capture(board, row, col)
    moves = []
    y_displace = team_mod(1)
    right_diag = board[row + 1][col + y_displace]
    left_diag = board[row - 1][col + y_displace]
    moves << right_diag unless right_diag.nil? || right_diag.team == @team
    moves << left_diag unless left_diag.nil? || left_diag.team == @team
    moves
  end
end
