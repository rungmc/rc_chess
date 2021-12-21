# frozen_string_literal: true

require_relative '../../lib/pieces/piece'
require_relative '../../lib/pieces/king'
require_relative '../../lib/pieces/rook'

describe 'King' do
  let(:bkg) { King.new('black', 'K') }
  let(:wkg) { King.new('white', 'K') }
  let(:brk) { Rook.new('black', 'R') }

  describe '#moveset' do
    context 'when king has free space on all sides' do
      let(:grid) do
        [
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, wkg, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'can move to every adjacent square' do
        wkg.moved = true
        expect(wkg.moveset(grid, 1, 1)).to match_array [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2] ]
      end
    end

    context 'when king is boxed in (per grid)' do
      let(:grid) do
        [
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, wkg, wkg, wkg, nil, nil, nil],
          [nil, nil, bkg, wkg, nil, nil, nil, nil],
          [nil, nil, wkg, bkg, bkg, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'has exactly 4 potential moves' do
        wkg.moved = true
        expect(wkg.moveset(grid, 3, 3).size).to be 4
        expect(wkg.moveset(grid, 3, 3)).to match_array [[3, 2], [4, 3], [4, 4], [3, 4]]
      end
    end

    describe '#castling' do
      context 'when the king has a free path to rooks' do
        let(:grid) do
          [
            [nil, nil, nil, nil, nil, nil, nil, brk],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, bkg],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, brk]
          ]
        end

        it 'returns the coordinate of the rooks if no pieces have moved' do
          expect(bkg.moveset(grid, 4, 7)).to include [0, 7], [7, 7]
        end

        it 'returns nothing if the king has moved' do
          bkg.moved = true
          expect(bkg.moveset(grid, 4, 7)).not_to include [0, 7], [7, 7]
        end

        it 'returns only the value of one pawn if the other has moved' do
          bkg.moved = false
          brk.moved = true
          grid[0][7] = Rook.new('black', 'R')
          expect(bkg.moveset(grid, 4, 7)).to include [0, 7]
          expect(bkg.moveset(grid, 4, 7)).not_to include [7, 7]
        end
      end

      context 'when the path to an unmoved rook is obstructed' do
        let(:grid) do
          [
            [nil, nil, nil, nil, nil, nil, nil, brk],
            [nil, nil, nil, nil, nil, nil, nil, brk],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, bkg],
            [nil, nil, nil, nil, nil, nil, nil, wkg],
            [nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, brk]
          ]
        end

        it 'does not return the coordinates of the rook' do
          expect(bkg.moveset(grid, 4, 7)).not_to include [0, 7], [7, 7]
        end
      end
    end
  end
end
