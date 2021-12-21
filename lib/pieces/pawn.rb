# frozen_string_literal: true

require_relative 'piece'

# Basic state and moveset for pawns.
class Pawn < Piece
  def moveset(board, row, col)
    moves = []
    moves += standard(board, row, col)
    moves += opening_double(board, row, col)
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
    return [] unless board[row][col + y_displace].nil?

    [[row, col + y_displace]]
  end

  # Moves forward two spaces if first move and free
  def opening_double(board, row, col)
    y_displace = team_mod(2)
    return [] unless board[row][col + y_displace].nil? && board[row][col + (y_displace / 2)].nil? && !moved?

    [[row, col + y_displace]]
  end

  # Captures diagonally.
  def capture(board, row, col)
    moves = []
    y_index = col + team_mod(1)
    x_right = row + 1
    x_left = row - 1
    right_diag = [x_right, y_index] unless row == 7 || !y_index.between?(0, 7)
    left_diag = [x_left, y_index] unless row.zero? || !y_index.between?(0, 7)
    moves << right_diag unless board[x_right][y_index].nil? || board[x_right][y_index].team == @team
    moves << left_diag unless board[x_left][y_index].nil? || board[x_left][y_index].team == @team
    moves
  end
end
