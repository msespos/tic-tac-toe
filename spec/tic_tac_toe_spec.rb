# frozen_string_literal: true

require_relative '../lib/tic_tac_toe.rb'

# describe Game do
#  describe '#initialize' do

#  end
# end

RSpec.describe Board do
  describe '#initialize' do
    context 'when initializing' do
      subject(:board) { Board.new }

      it 'sets @grid to the correct array' do
        expect(board.grid).to eq([1, 2, 3, 4, 5, 6, 7, 8, 9])
      end
    end
  end
end
