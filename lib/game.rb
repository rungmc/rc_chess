# frozen_string_literal: true

require_relative 'board'
require_relative 'display'

# Runs a game of chess.
class Game
  include Display

  def initialize(board = Board.new, white_turn: true)
    @board = board
    @white_turn = white_turn
    draw(@board, @white_turn) # Display method
  end

  def play
    loop do
      player_input
      draw(@board, @white_turn)
      break if @board.checkmate?

      change_turns
    end
    declare_winner # Display method
  end

  def player_input
    loop do
      choose_piece # Display method
      get_moves
      show_moves
      wait_input
    end
    apply_move
  end

  def change_turns
    @white_turn = !@white_turn
  end
end
