# frozen_string_literal: true

require_relative 'board'

class Game
  def initialize(@board = Board.new, white_turn: true)
    @board = board
    @white_turn = white_turn
  end

  def play
    loop do
      player_input
      update_board
      break if @board.checkmate?
      change_turns
    end
    declare_winner
    enable_history # opt. display method
  end
end
