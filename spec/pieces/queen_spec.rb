# frozen_string_literal: true

require_relative '../../lib/pieces/piece'
require_relative '../../lib/pieces/queen'

describe Queen do
  let(:bqn) { Queen.new('black', 'Q') }
  let(:wqn) { Queen.new('white', 'Q') }

  describe '#moveset' do
    context 'when the queen has free reign over the entire board (per grid)' do
      let(:grid) do
        [
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, bqn, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'can traverse an entire row' do
        expect(bqn.moveset(grid, 3, 3)).to include [0, 3], [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3]
      end

      it 'can traverse an entire column' do
        expect(bqn.moveset(grid, 3, 3)).to include [3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7]
      end

      it 'can move in both directions diagonally' do
        expect(bqn.moveset(grid, 3, 3)).to include [0, 0], [1, 1], [2, 2], [4, 4], [5, 5], [6, 6], [7, 7]
        expect(bqn.moveset(grid, 3, 3)).to include [6, 0], [5, 1], [4, 2], [2, 4], [1, 5], [0, 6]
      end

      it 'has a total moveset size of 27' do
        expect(bqn.moveset(grid, 3, 3).size).to be 27
      end
    end

    context 'when the queen is boxed in (per grid)' do
      let(:grid) do
        [
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, bqn, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, wqn, bqn, nil, nil, nil],
          [nil, nil, bqn, bqn, nil, wqn, nil, nil],
          [nil, nil, wqn, bqn, bqn, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'has 5 possible moves' do
        expect(bqn.moveset(grid, 3, 3).size).to be 5
        expect(bqn.moveset(grid, 3, 3)).to match_array [[2, 2], [4, 2], [2, 3], [3, 4], [3, 5]]
      end
    end

    context 'when queen is sitting on the edge of the board' do
      let(:grid) do
        [
          [wqn, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil]
        ]
      end

      it 'has no off board moves' do
        wqn.moveset(grid, 0, 0).each do |move|
          expect(move[0].between?(0, 7)).to be true
          expect(move[1].between?(0, 7)).to be true
        end
      end
    end
  end
end
