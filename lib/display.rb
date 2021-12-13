# frozen_string_literal: true

require 'curses'

# Outputs game to CLI with curses.
module Display
  PIECES_UNICODE = {
    'white' => {
      'P' => "\u2659",
      'R' => "\u2656",
      'N' => "\u2658",
      'B' => "\u2657",
      'Q' => "\u2655",
      'K' => "\u2654"
    },
    'black' => {
      'P' => "\u265f",
      'R' => "\u265c",
      'N' => "\u265e",
      'B' => "\u265d",
      'Q' => "\u265b",
      'K' => "\u265a"
    }
  }.freeze

  def initialize
    Curses.init_screen
  end

  def menu
  end

  def draw(board)
    board.each_with_index do |col, y|
      col.each_with_index do |square, x|
        Curses.setpos(x + 1, y + 1)
        square.nil? ? Curses.addstr(' ') : Curses.addstr(PIECES_UNICODE[square.team][square.symbol])
      end
    end
    Curses.refresh
  end
end
