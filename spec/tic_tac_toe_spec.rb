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
end

RSpec.describe Board do
  subject(:board) { Board.new }
  describe '#win_possibilities' do
    context 'when creating the win_possibilities array' do
      it 'creates the correct array' do
        arr = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        expect(board.win_possibilities).to eq(arr)
      end
    end
  end

  describe '#occupied?' do
    context 'when given the number of a square that has an X' do
      it 'returns true' do
        board.instance_variable_set(:@grid, [1,2,'X',4,5,6,7,8,9])
        expect(board.occupied?(3)).to eq(true)
      end
    end
    context 'when given the number of a square that has an O' do
      it 'returns true' do
        board.instance_variable_set(:@grid, [1,2,'O',4,5,6,7,8,9])
        expect(board.occupied?(3)).to eq(true)
      end
    end
    context 'when given the number of a square that is empty' do
      it 'returns false' do
        expect(board.occupied?(3)).to eq(false)
      end
    end
  end

  describe '#populate_square' do
    context 'when given a token and a number' do
      it 'populates the grid array appropriately' do
        board.populate_square("X",1)
        expect(board.grid).to eq(["X",2,3,4,5,6,7,8,9])
      end
    end
  end

  describe '#determine_winner' do
    context 'when given a grid with a horizontal win of three Xs' do
      it 'returns X' do
        board.instance_variable_set(:@grid, ["X","X","X","O","O",6,7,8,9])
        expect(board.determine_winner).to eq("X")
      end
    end

    context 'when given a grid with a vertical win of three Os' do
      it 'returns O' do
        board.instance_variable_set(:@grid, ["O","X",3,"O","X",6,"O",8,9])
        expect(board.determine_winner).to eq("O")
      end
    end

    context 'when given a grid with a tied game' do
      it 'returns :no_winner' do
        board.instance_variable_set(:@grid, ["X","O","X","O","O","X","X","X","O"])
        expect(board.determine_winner).to eq(:no_winner)
      end
    end
  end
end
