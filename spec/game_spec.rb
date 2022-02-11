# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  subject(:game) { described_class.new }

  describe '#play' do
    # Main gameplay loop, no direct testing required.
  end

  describe '#player_input' do
    # Player input loop.
  end

  describe '#change_turns' do
    context 'when called' do
      it 'returns white on black turn' do
        game.instance_variable_set(:@current_turn, 'black')
        expect(game.change_turns).to be 'white'
      end

      it 'returns black on white turn' do
        game.instance_variable_set(:@current_turn, 'white')
        expect(game.change_turns).to be 'black'
      end
    end
  end

  describe '#next_board' do
    let(:start) { [0, 1] }
    let(:dest) { [0, 2] }
    #let(:new_board) { game.next_board(start, dest) }

    context 'when provided with a set of movement coordinates' do
      it 'does not alter the main game board' do
        new_board = game.next_board(start, dest)
        expect(game.board.grid).not_to eq new_board
      end

      it 'applies the moves successfully within the cloned board' do
      end
    end
  end

  describe '#board_scan' do
    # Simply iterates through the 2D board one square at a time and yields operation to other methods.
  end

  describe '#king_location' do
    context '' do
    end
  end

  describe '#check?' do
  end

  describe '#checkmate?' do
  end

  describe '#stalemate?' do
  end
end
