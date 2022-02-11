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
        board.grid.each { |i| expect(i[1].is_a?(Pawn)).to be true }
      end

      it 'creates a row of black pawns at A7-H7/(0..7, 6)' do
        board.grid.each { |i| expect(i[6].is_a?(Pawn)).to be true }
      end
    end
  end

  describe '#move' do
    let(:origin) { [0, 1] }
    let(:dest) { [0, 2] }

    context 'executes a movement from an origin point to a destination point' do
      before { board.move(origin, dest) }

      it 'adds the piece at the destination coordinate' do
        dest_sq = board.grid[dest[0]][dest[1]]
        expect(dest_sq).not_to be_nil
        expect(dest_sq).to be_a Pawn
      end

      it 'removes the piece from the origin coordinate' do
        start_sq = board.grid[origin[0]][origin[1]]
        expect(start_sq).to be_nil
      end
    end
  end

  # Currently skipped, passes if method is not private.
  describe '#readable' do
    context 'when given a set of x,y coordinates' do
      xit 'translates to chess notation' do
        expect(board.readable([3,4])).to eq("D5")
      end
    end
  end

  # Currently skipped, passes if method is not private.
  describe '#check_capture' do
    context 'when the space being moved to has nothing on it' do
      xit 'returns -' do
        expect(board.check_capture([3,3])).to eq('-')
      end
    end

    context 'when there is already a piece in the space' do
      xit 'returns x with the symbol of the captured piece' do
        expect(board.check_capture([1,0])).to eq("xN")
      end
    end
  end
end
