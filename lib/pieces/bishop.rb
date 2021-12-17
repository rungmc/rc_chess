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

  private

  def right_up(board, row, col)
    moves = []
    # Iterates to board edge (x axis).
    ((row + 1)..7).each_with_index do |row_index, steps|
      col_index = (col + 1) + steps
      # Guards vs out of bounds (y axis).
      break if col_index > 7

      curr_sq = board[row_index][col_index]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row_index][col_index]
      # Breaks after capture.
      break if curr_sq.team != @team
    end
    moves
  end

  def right_down(board, row, col)
    moves = []
    # Iterates to board edge (x axis).
    ((row + 1)..7).each_with_index do |row_index, steps|
      col_index = (col - 1) - steps
      # Guards vs out of bounds (y axis).
      break if col_index.negative?

      curr_sq = board[row_index][col_index]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row_index][col_index]
      # Breaks after capture.
      break if curr_sq.team != @team
    end
    moves
  end

  def left_up(board, row, col)
    moves = []
    # Iterates to board edge (x axis).
    (0..(row - 1)).reverse.each_with_index do |row_index, steps|
      col_index = (col + 1) + steps
      # Guards vs out of bounds (y axis).
      break if col_index > 7

      curr_sq = board[row_index][col_index]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row_index][col_index]
      # Breaks after capture.
      break if curr_sq.team != @team
    end
    moves
  end

  def left_down(board, row, col)
    moves = []
    # Iterates to board edge (x axis).
    (0..(row - 1)).reverse.each_with_index do |row_index, steps|
      col_index = (col - 1) - steps
      # Guards vs out of bounds (y axis).
      break if col_index.negative?

      curr_sq = board[row_index][col_index]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row_index][col_index]
      # Breaks after capture.
      break if curr_sq.team != @team
    end
    moves
  end
end
