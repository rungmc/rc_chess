# frozen_string_literal: true

# Generic chess piece class.
class Piece
  attr_reader :team, :symbol
  attr_accessor :moved
  alias moved? moved

  def initialize(team, symbol, moved: false)
    @team = team
    @symbol = symbol
    @moved = moved
  end

  private

  # Common movement patterns:

  # Set coordinate movement/teleportation (knight, king)
  def teleport(coord_arr, board, row, col)
    moves = []
    coord_arr.each do |i|
      x_index = i[0] + row
      y_index = i[1] + col
      # Guards against out of bounds
      next unless x_index.between?(0, 7) && y_index.between(0, 7)

      next_pos = board[x_index][y_index]
      moves << [x_index, y_index] unless next_pos.team == @team
    end
    moves
  end

  # Collision-based left/right movement (rook, queen)
  # NOTE: The methods below could be reduced to something cleaner/more concise.
  def right(board, row, col)
    moves = []
    # Iterates to board edge (x axis).
    ((row + 1)..7).each do |row_index|
      curr_sq = board[row_index][col]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row_index, col]
      # Breaks after capture.
      break unless curr_sq.nil?
    end
    moves
  end

  def left(board, row, col)
    moves = []
    # Iterates to board edge (x axis).
    (0..(row - 1)).reverse_each do |row_index|
      curr_sq = board[row_index][col]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row_index, col]
      # Breaks after capture.
      break unless curr_sq.nil?
    end
    moves
  end

  def up(board, row, col)
    moves = []
    # Iterates to board edge (y axis).
    ((col + 1)..7).each do |col_index|
      curr_sq = board[row][col_index]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row, col_index]
      # Breaks after capture.
      break unless curr_sq.nil?
    end
    moves
  end

  def down(board, row, col)
    moves = []
    # Iterates to board edge (y axis).
    (0..(col - 1)).reverse_each do |col_index|
      curr_sq = board[row][col_index]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row, col_index]
      # Breaks after capture.
      break unless curr_sq.nil?
    end
    moves
  end

  # Collision-based diagonal movement (bishop, queen)
  # NOTE: The methods below could be reduced to something cleaner/more concise.
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

      moves << [row_index, col_index]
      # Breaks after capture.
      break unless curr_sq.nil?
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

      moves << [row_index, col_index]
      # Breaks after capture.
      break unless curr_sq.nil?
    end
    moves
  end

  def left_up(board, row, col)
    moves = []
    # Iterates to board edge (x axis).
    (0..(row - 1)).to_a.reverse.each_with_index do |row_index, steps|
      col_index = (col + 1) + steps
      # Guards vs out of bounds (y axis).
      break if col_index > 7

      curr_sq = board[row_index][col_index]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row_index, col_index]
      # Breaks after capture.
      break unless curr_sq.nil?
    end
    moves
  end

  def left_down(board, row, col)
    moves = []
    # Iterates to board edge (x axis).
    (0..(row - 1)).to_a.reverse.each_with_index do |row_index, steps|
      col_index = (col - 1) - steps
      # Guards vs out of bounds (y axis).
      break if col_index.negative?

      curr_sq = board[row_index][col_index]
      # Breaks unless sq empty or enemy piece.
      break unless curr_sq.nil? || curr_sq.team != @team

      moves << [row_index, col_index]
      # Breaks after capture.
      break unless curr_sq.nil?
    end
    moves
  end
end
