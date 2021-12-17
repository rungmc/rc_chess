# frozen_string_literal: true

describe Pawn do
  describe '#moveset' do
    context 'when there are no pieces in front of the pawn' do
      it 'allows pawn to move forward one space' do
      end

      it 'allows the pawn to move two spaces on first move' do
      end

      it 'does not allow pawn to move two spaces after first move' do
      end

      it 'does not allow pawn to move diagonally' do
      end
    end

    context 'when a pawn is surrounded by enemy pieces' do
      it 'only allows pawn to capture diagonally' do
      end
    end

    context 'when a pawn is surrounded by friendly pieces' do
      it 'has no moves' do
      end
    end
  end
end
