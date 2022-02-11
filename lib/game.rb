# frozen_string_literal: true

require_relative 'board'
require_relative 'display'

# Runs a game of chess, enforcing all rules.
class Game
  include Display

  attr_reader :board, :current_turn

  def initialize(board = Board.new, current_turn = 'white')
    @board = board
    @current_turn = current_turn
  end

  ###############################################
  # Gameplay loop
  ###############################################

  def play
    loop do
      draw(@board, @current_turn) # Display method
      player_input
      draw(@board, @current_turn)
      break if checkmate? || stalemate?

      @current_turn = change_turns
    end
    declare_winner # Display method
  end

  def player_input
    loop do
      show_moves(filter_illegal(choose_piece))
      wait_input
    end
    apply_move
  end

  def change_turns
    @current_turn == 'white' ? 'black' : 'white'
  end

  ###############################################
  # Game state management
  ###############################################

  # Clones board and applies the next move for validation purposes.
  def next_board(start, destination)
    next_board = @board
    next_board.move(start, destination)
    next_board.grid
  end

  # Iterates through board square by square.
  def board_scan(board = @board.grid)
    board.each_with_index do |row, x|
      row.each_with_index do |square, y|
        yield x, y, square
      end
    end
  end

  # Locates king of specified team.
  def king_location(team = @current_turn, board = @board)
    board_scan(board) { |x, y, square| return [x, y] if square.is_a?(King) && square.team == team }
  end

  # Scans board to see if any piece of player can attack king on next turn.
  def check?(board = @board.grid, team = @current_turn)
    board_scan(board) do |x, y, square|
      next if square.nil? || square.team != team
      return true if square.moveset(board, x, y).any? { |move| move == king_location(change_turns, board) }
    end
    false
  end

  # Is there no way out of a check?
  def checkmate?(board = @board.grid, team = @current_turn)
    return false unless check?(board.grid, team)
  end

  # Is there a valid move that can be made without putting self in checkmate?
  def stalemate?(board = @board.grid, team = @current_turn)
    return false if check?(board.grid, team)

    board_scan(board) do |x, y, square|
      next if square.nil? || square.team == team
      return false unless square.moveset.all? { |move| check?(next_board([x, y], move), team) }
    end
    true
  end

  ###############################################
  # Move pruning functions
  ###############################################

  # Disallows moves that result in self-check.
  def filter_illegal(coord)
    potential_moves = @board.grid[coord[0]][coord[1]].moveset
    potential_moves = potential_moves.reject { |move| check?(next_board(coord, move), change_turns) }
    potential_moves - filter_castle(coord, potential_moves)
  end

  #  # Can't move through check on path to castle.
  #  def filter_castle(coord, potential_moves)
  #    return [] unless @board[coord[0]][coord[1]].is_a?(King)
  #
  #    castle_moves = potential_moves.select { |move| @board[move[0]][move[1]].is_a?(Rook) &&
  #      @board[move[0]][move[1]].team == @board[coord[0]][coord[1]].team}
  #  end
end
