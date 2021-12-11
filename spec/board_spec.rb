# frozen_string_literal: true

describe Board do
  subject(:board) { described_class.new }
  
  describe '#initialize' do
  end

  describe '#update' do
    it '' do
    end

    it '' do
    end
  end

  describe '#readable' do
    it ''
  end

  describe '#note_capture' do
    context 'when the space being moved to is nil' do
      it 'returns -' do
      end
    end

    context 'when there is already a piece in the space' do
      it 'returns x with the symbol of the captured piece' do
      end
    end
  end
end
