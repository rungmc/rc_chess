# frozen_string_literal: true

require_relative 'pieces/piece'
require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/king'

# Establishes the chess grid, stores all location data.
class Board
  attr_accessor :grid, :history

  def initialize(grid = fresh_board, history = [])
    @grid = grid
    @history = history
  end

  def fresh_board
    # Format: grid[x][y]
    grid = Array.new(8) { Array.new(8) }
    grid = place_pawns(grid)
    grid = place_rooks(grid)
    grid = place_knights(grid)
    grid = place_bishops(grid)
    grid = place_queens(grid)
    place_kings(grid)
  end

  # Executes a move (no checks for validity) and adds it to the grid history.
  def move(start, destination)
    piece = @grid[start[0]][start[1]]
    @grid[start[0]][start[1]] = nil
    @grid[destination[0]][destination[1]] = piece
    piece.moved = true

    @history << "#{piece.symbol}#{readable(start)}#{check_capture(destination)}#{readable(destination)}"
    nil
  end

  private

  # Translates internally used coordinates to chess notation.
  def readable(coord)
    "#{%w[A B C D E F G H][coord[0]]}#{coord[1] + 1}"
  end

  # Denotes whether or not a capture has occurred by executing a move.
  def check_capture(coord)
    @grid[coord[0]][coord[1]].nil? ? '-' : "x#{@grid[coord[0]][coord[1]].symbol}"
  end

  def place_pawns(grid)
    grid.each do |row|
      row[1] = Pawn.new('white', 'P')
      row[6] = Pawn.new('black', 'P')
    end
  end

  def place_rooks(grid)
    grid[0][0] = Rook.new('white', 'R')
    grid[7][0] = Rook.new('white', 'R')
    grid[0][7] = Rook.new('black', 'R')
    grid[7][7] = Rook.new('black', 'R')
    grid
  end

  def place_knights(grid)
    grid[1][0] = Knight.new('white', 'N')
    grid[6][0] = Knight.new('white', 'N')
    grid[1][7] = Knight.new('black', 'N')
    grid[6][7] = Knight.new('black', 'N')
    grid
  end

  def place_bishops(grid)
    grid[2][0] = Bishop.new('white', 'B')
    grid[5][0] = Bishop.new('white', 'B')
    grid[2][7] = Bishop.new('black', 'B')
    grid[5][7] = Bishop.new('black', 'B')
    grid
  end

  def place_queens(grid)
    grid[3][0] = Queen.new('white', 'Q')
    grid[3][7] = Queen.new('black', 'Q')
    grid
  end

  def place_kings(grid)
    grid[4][0] = King.new('white', 'K')
    grid[4][7] = King.new('black', 'K')
    grid
  end
end
