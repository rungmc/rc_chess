# frozen_string_literal: true

require_relative '../../lib/board'
require_relative '../../lib/pieces/piece'
require_relative '../../lib/pieces/pawn'

describe Pawn do
  let(:bpn) { Pawn.new('black', 'P') }
  let(:wpn) { Pawn.new('white', 'P') }

  describe '#moveset' do
    context 'when there are no pieces in front of the pawn' do
      let(:grid) do
        [
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, bpn, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, wpn, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'allows pawn to move forward one space' do
        expect(wpn.moveset(grid, 6, 1)).to include [6, 2]
        expect(bpn.moveset(grid, 1, 6)).to include [1, 5]
      end

      it 'allows the pawn to move two spaces on first move' do
        expect(wpn.moveset(grid, 6, 1)).to include [6, 3]
      end

      it 'does not allow pawn to move two spaces after first move' do
        wpn.moved = true
        expect(wpn.moveset(grid, 6, 1)).to_not include [6, 3]
      end

      it 'does not allow pawn to move diagonally' do
        expect(wpn.moveset(grid, 6, 1)).to_not include [5, 2], [7, 2]
      end
    end

    context 'when a pawn is surrounded by enemy pieces' do
      let(:grid) do
        [
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, bpn, nil, nil, nil, nil, nil],
          [nil, wpn, bpn, nil, nil, nil, nil, nil],
          [nil, nil, bpn, nil, nil, nil, nil, nil]
        ]
      end

      it 'only allows pawn to capture diagonally' do
        expect(wpn.moveset(grid, 6, 1)).to match_array [[5, 2], [7, 2]]
      end
    end

    context 'when a pawn is blocked by a teammate' do
      let(:grid) do
        [
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, wpn, nil, nil, nil, nil, nil],
          [nil, wpn, wpn, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'has no moves' do
        expect(wpn.moveset(grid, 6, 1)).to match_array []
      end
    end
  end
end
