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
  COLUMN_LABELS = %w[A B C D E F G H].freeze
  EMPTY_SPACE = "\u00A0"
  # HORIZ_SPACER = "\u2009"

  def initialize
    Curses.init_screen
    Curses.start_color
    Curses.init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_BLACK) # Black sq
    Curses.init_pair(2, Curses::COLOR_BLACK, Curses::COLOR_WHITE) # White sq
    # Curses.init_pair(3) # Purp sq (show moves)
    # Curses.init_pair(4) # Green sq (selected)
  end

  def menu
  end

  def draw(board)
    label_grid
    board.each_with_index do |col, y|
      col.each_with_index do |square, x|
        Curses.setpos(x, (y * 2) + 2)
        Curses.attrset(Curses.color_pair(2))
        Curses.addstr(square.nil? ? EMPTY_SPACE : PIECES_UNICODE[square.team][square.symbol])
        Curses.addstr(EMPTY_SPACE)
      end
    end
    Curses.refresh
  end

  def label_grid
    (0..7).each do |i|
      Curses.setpos(7 - i, 0)
      Curses.addstr((i + 1).to_s)
      Curses.setpos(8, (i * 2) + 2)
      Curses.addstr(COLUMN_LABELS[i] + EMPTY_SPACE)
    end
  end
end
