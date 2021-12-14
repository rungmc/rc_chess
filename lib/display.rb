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
  EMPTY_SPACE = "\u00a0"

  Curses.init_screen
  Curses.start_color
  Curses.init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_BLACK) # "Black" sq
  Curses.init_pair(2, Curses::COLOR_WHITE, Curses::COLOR_GREEN) # White sq
  Curses.init_pair(3, Curses::COLOR_WHITE, Curses::COLOR_RED) # Avail. moves

  def menu; end

  # Draws the screen
  def draw(board, white_turn = true, status_msg = "Test message!")
    label_board
    draw_board(board.grid)
    Curses.attrset(Curses.color_pair(1))
    draw_history(board.history)
    draw_turn(white_turn)
    draw_status(status_msg)
    Curses.refresh
  end

  # Draws chess board and pieces
  def draw_board(board)
    white_space = true
    board.each_with_index do |col, x|
      col.each_with_index do |square, y|
        # Curses uses (y, x) for coords.
        Curses.setpos(y + 1, (x * 2) + 3)
        Curses.attrset(white_space ? Curses.color_pair(2) : Curses.color_pair(1))
        Curses.addstr((square.nil? ? EMPTY_SPACE : PIECES_UNICODE[square.team][square.symbol]) + EMPTY_SPACE)
        white_space = !white_space
      end
      white_space = !white_space
    end
  end

  # Labels grid
  def label_board
    Curses.attrset(Curses.color_pair(1))
    (0..7).each do |i|
      Curses.setpos(8 - i, 1)
      Curses.addstr((i + 1).to_s)
      Curses.setpos(9, (i * 2) + 3)
      Curses.addstr(COLUMN_LABELS[i])
    end
  end

  # Tells player whose turn it is
  def draw_turn(white_turn)
    Curses.setpos(11, 1)
    turn = white_turn ? 'white' : 'black'
    Curses.addstr("It is #{turn}'s turn.")
  end

  # Status text at bottom
  def draw_status(status_msg)
    return if status_msg.nil?

    Curses.setpos(12, 1)
    Curses.addstr(status_msg)
  end

  # Displays last 7 moves
  def draw_history(history)
    Curses.setpos(1, 20)
    Curses.addstr('Recent:')
    (0..6).each do |i|
      break if history[i].nil?

      Curses.setpos(i + 2, 22)
      Curses.addstr(history[i])
    end
  end
end
