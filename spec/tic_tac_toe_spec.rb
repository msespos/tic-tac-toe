# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/tic_tac_toe.rb'

RSpec.describe Game do
  subject(:game) { Game.new }
  describe '#play_game' do
    context 'when playing game' do
      before do
        allow(game).to receive(:determine_first_player)
        allow(game).to receive(:play_turns)
        allow(game).to receive(:puts)
      end

      it 'calls determine_first_player' do
        expect(game).to receive(:determine_first_player)
        game.play_game
      end

      it 'calls play_turns' do
        expect(game).to receive(:play_turns)
        game.play_game
      end

      it 'calls declare_winner' do
        expect(game).to receive(:declare_winner)
        game.play_game
      end
    end
  end

  describe '#determine_first_player' do
    context 'when :gets returns "X"' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('X')
      end

      it 'sets @current_player to "X"' do
        expect(game.determine_first_player).to eq('X')
      end
    end

    context 'when :gets returns an invalid value then returns "O"' do
      before do
        allow(game).to receive(:puts).twice
        allow(game).to receive(:gets).and_return('A', 'O')
      end

      it 'sets @current_player to "O"' do
        expect(game.determine_first_player).to eq('O')
      end
    end
  end

  # got assistance with this test from rlmoser
  describe '#game_over?' do
    let(:board_over) { instance_double(Board) }
    context 'when @board.determine_winner returns "X"' do
      it 'returns true' do
        allow(board_over).to receive(:determine_winner).and_return('X')
        game.instance_variable_set(:@board, board_over)
        expect(game.game_over?).to be true
      end
    end

    context 'when @board.determine_winner returns "O"' do
      it 'returns true' do
        allow(board_over).to receive(:determine_winner).and_return('O')
        game.instance_variable_set(:@board, board_over)
        expect(game.game_over?).to be true
      end
    end

    context 'when @board.determine_winner returns :no_winner' do
      it 'returns false' do
        allow(board_over).to receive(:determine_winner).and_return(:no_winner)
        game.instance_variable_set(:@board, board_over)
        expect(game.game_over?).to be false
      end
    end

    context 'when @counter is 9' do
      it 'returns true' do
        game.instance_variable_set(:@counter, 9)
        expect(game.game_over?).to be true
      end
    end
  end

  describe '#play_turns' do
    context '' do
    end
  end

  describe '#tie_or_win' do
    let(:board_over) { instance_double(Board) }
    context 'when @board.determine_winner returns :no_winner' do
      it 'returns "It\'s a tie!"' do
        allow(board_over).to receive(:determine_winner).and_return(:no_winner)
        game.instance_variable_set(:@board, board_over)
        expect(game.tie_or_win).to eq('It\'s a tie!')
      end
    end

    context 'when @board.determine_winner returns "X"' do
      it 'returns "X wins!"' do
        allow(board_over).to receive(:determine_winner).and_return('X')
        game.instance_variable_set(:@board, board_over)
        expect(game.tie_or_win).to eq('X wins!')
      end
    end

    context 'when @board.determine_winner returns "O"' do
      it 'returns "O wins!"' do
        allow(board_over).to receive(:determine_winner).and_return('O')
        game.instance_variable_set(:@board, board_over)
        expect(game.tie_or_win).to eq('O wins!')
      end
    end
  end

  describe '#declare_winner' do
    context 'when counter is 9' do
      it 'returns result of tie_or_win' do
        allow(game).to receive(:tie_or_win).and_return('It\'s a tie!')
        game.instance_variable_set(:@counter, 9)
        expect(game.declare_winner).to eq('It\'s a tie!')
      end
    end

    let(:board_over) { instance_double(Board) }
    context 'when counter is 8' do
      it 'returns result of @board.determine_winner' do
        allow(board_over).to receive(:determine_winner).and_return('X')
        game.instance_variable_set(:@board, board_over)
        game.instance_variable_set(:@counter, 8)
        expect(game.declare_winner).to eq('X wins!')
      end
    end
  end

  describe '#process_input' do
    let(:board_over) { instance_double(Board) }
    context 'when the token is "X" and the input is 1' do
      before do
        allow(board_over).to receive(:determine_winner).and_return('X')
        game.instance_variable_set(:@board, board_over)
        allow(game).to receive(:puts)
        allow(game).to receive(:valid_input).and_return(1)
      end

      it 'passes "X" and 1 to @board.populate square' do
        expect(board_over).to receive(:populate_square).with('X', 1)
        game.process_input('X')
      end
    end
  end
end

RSpec.describe Board do
  subject(:board) { Board.new }
  describe '#win_possibilities' do
    context 'when creating the win_possibilities array' do
      it 'creates the correct array' do
        arr = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        expect(board.win_possibilities).to eq(arr)
      end
    end
  end

  describe '#occupied?' do
    context 'when given the number of a square that has an X' do
      it 'returns true' do
        board.instance_variable_set(:@grid, [1, 2, 'X', 4, 5, 6, 7, 8, 9])
        x_position = 3
        expect(board.occupied?(x_position)).to be true
      end
    end
    context 'when given the number of a square that has an O' do
      it 'returns true' do
        board.instance_variable_set(:@grid, [1, 2, 'O', 4, 5, 6, 7, 8, 9])
        o_position = 3
        expect(board.occupied?(o_position)).to be true
      end
    end
    context 'when given the number of a square that is empty' do
      it 'returns false' do
        empty_position = 3
        expect(board.occupied?(empty_position)).to be false
      end
    end
  end

  describe '#populate_square' do
    context 'when given a token and a number' do
      it 'populates the grid array appropriately' do
        board.populate_square('X', 1)
        expect(board.instance_variable_get(:@grid)).to eq(['X', 2, 3, 4, 5, 6, 7, 8, 9])
      end
    end
  end

  describe '#determine_winner' do
    context 'when given a grid with a horizontal win of three "X"s' do
      it 'returns "X"' do
        board.instance_variable_set(:@grid, ['X', 'X', 'X', 'O', 'O', 6, 7, 8, 9])
        expect(board.determine_winner).to eq('X')
      end
    end

    context 'when given a grid with a vertical win of three "O"s' do
      it 'returns "O"' do
        board.instance_variable_set(:@grid, ['O', 'X', 3, 'O', 'X', 6, 'O', 8, 9])
        expect(board.determine_winner).to eq('O')
      end
    end

    context 'when given a grid with a tied game' do
      it 'returns :no_winner' do
        board.instance_variable_set(:@grid, %w[X O X O O X X X O])
        expect(board.determine_winner).to eq(:no_winner)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
