# frozen_string_literal: true

require_relative '../lib/tic_tac_toe.rb'

RSpec.describe Game do
  describe '#play_game' do
    context 'when playing game' do
      subject(:game) { Game.new }
      before do
        allow(game).to receive(:determine_first_player)
        allow(game).to receive(:play_turns)
        allow(game).to receive(:puts)
      end

      it 'calls determine_first_player' do
        expect(game).to receive(:determine_first_player)
        game.play_game
      end

      it 'calls declare_winner' do
        expect(game).to receive(:declare_winner)
        game.play_game
      end
    end
  end

  describe 'determine_first_player' do
  end
end
