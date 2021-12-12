# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/pieces/piece'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/knight'
require_relative '../lib/pieces/bishop'
require_relative '../lib/pieces/rook'
require_relative '../lib/pieces/queen'
require_relative '../lib/pieces/king'

describe Board do
  subject(:board) { described_class.new }

  describe '#fresh_board' do
    context 'when starting a new game' do
      it 'creates a row of white pawns at A2-H2/(0..7, 1)' do
        board.board.each { |i| expect(i[1].is_a?(Pawn)).to be true }
      end

      it 'creates a row of black pawns at A7-H7/(0..7, 6)' do
        board.board.each { |i| expect(i[6].is_a?(Pawn)).to be true }
      end
    end
  end

  describe '#readable' do
    context 'when given a set of x,y coordinates' do
      it 'translates to chess notation' do
        expect(board.readable([3,4])).to eq("D5")
      end
    end
  end

  describe '#check_capture' do
    context 'when the space being moved to has nothing on it' do
      it 'returns -' do
        expect(board.check_capture([3,3])).to eq('-')
      end
    end

    context 'when there is already a piece in the space' do
      it 'returns x with the symbol of the captured piece' do
        expect(board.check_capture([1,0])).to eq("xN")
      end
    end
  end
end
