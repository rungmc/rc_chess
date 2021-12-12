# frozen_string_literal: true

require_relative 'pieces/chess_piece'
require_relative 'pieces/pawn'
require_relative 'pieces/knight'
require_relative 'pieces/bishop'
require_relative 'pieces/rook'
require_relative 'pieces/queen'
require_relative 'pieces/king'

# Establishes the chess board, stores all location data.
class Board
  attr_accessor :board, :history

  def initialize(board = fresh_board, history = [])
    @board = board
    @history = history
  end

  def fresh_board
    # Format: board[x][y]
    board = Array.new(8) { Array.new(8) }
    board = place_pawns(board)
    board = place_rooks(board)
    board = place_knights(board)
    board = place_bishops(board)
    board = place_queens(board)
    place_kings(board)
  end

  # Executes a move (no checks for validity) and adds it to the board history.
  def move(piece, start, destination)
    @board[start[0]][start[1]] = nil
    @board[destination[0]][destination[1]] = piece
    piece.moved = true

    @history << "#{piece.symbol}#{readable(start)}#{check_capture(destination)}#{readable(dest)}"
  end

  # Translates internally used coordinates to chess notation.
  def readable(coord)
    "#{%w[A B C D E F G H][coord[0]]}#{coord[1] + 1}"
  end

  # Denotes whether or not a capture has occurred by executing a move.
  def check_capture(coord)
    @board[coord[0]][coord[1]].nil? ? '-' : "x#{@board[coord[0]][coord[1]].symbol}"
  end

  private

  def place_pawns(board)
    board.each do |row|
      row[1] = Pawn.new('white', 'P')
      row[6] = Pawn.new('black', 'P')
    end
  end

  def place_rooks(board)
    board[0][0] = Rook.new('white', 'R')
    board[7][0] = Rook.new('white', 'R')
    board[0][7] = Rook.new('black', 'R')
    board[7][7] = Rook.new('black', 'R')
    board
  end

  def place_knights(board)
    board[1][0] = Knight.new('white', 'N')
    board[6][0] = Knight.new('white', 'N')
    board[1][7] = Knight.new('black', 'N')
    board[6][7] = Knight.new('black', 'N')
    board
  end

  def place_bishops(board)
    board[2][0] = Bishop.new('white', 'B')
    board[5][0] = Bishop.new('white', 'B')
    board[2][7] = Bishop.new('black', 'B')
    board[5][7] = Bishop.new('black', 'B')
    board
  end

  def place_queens(board)
    board[3][0] = Queen.new('white', 'Q')
    board[3][7] = Queen.new('black', 'Q')
    board
  end

  def place_kings(board)
    board[4][0] = King.new('white', 'K')
    board[4][7] = King.new('black', 'K')
    board
  end
end
