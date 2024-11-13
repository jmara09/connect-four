require_relative '../lib/connect_four'

describe ConnectFour do
  subject(:game) { described_class.new }

  describe '#insert_token' do
    context 'when player picks a column' do
      it 'should go all the way to the bottom' do
        token = 'white'
        column_input = 1
        column_bottom = -> { game.board[5][column_input - 1] }
        game.insert_token(token, column_input)
        expect(column_bottom.call).to eq(token)
      end
    end

    context 'when the bottom is taken' do
      before do
        token = 'white'
        column = 1
        game.insert_token(token, column)
      end

      it 'will put the value before it' do
        token = 'black'
        column = 1
        game.insert_token(token, column)
        second_to_last_row = game.board[4][column - 1]
        expect(second_to_last_row).to eq(token)
      end
    end

    context 'when the column is full' do
      before do
        tokens = [1, 2, 3, 4, 5, 6]
        column = 1
        tokens.each do |token|
          game.insert_token(token, column)
        end
      end

      it 'will return an error message' do
        token = 'black'
        column = 1
        error_message = 'This column is full. Please choose a different one.'
        expect(game).to receive(:puts).with(error_message)
        game.insert_token(token, column)
      end
    end
  end

  describe '#connect_diagonal' do
    let(:token) { game.white_token }
    context 'when there is a four consecutive element diagonally' do
      before do
        game.board[3][0] = token
        game.board[2][1] = token
        game.board[1][2] = token
        game.board[0][3] = token
        allow(game).to receive(:puts)
        allow(game).to receive(:connected?).and_return(true)
      end
      it 'stops the game and you win' do
        player = { name: 'John', token: token }
        board = game.board
        result = game.connect_diagonal(board, player)
        expect(result).to eq(true)
      end
    end

    context 'when there is no winning combination' do
      it 'returns false' do
        player = { name: 'Jane', token: token }
        board = game.board
        result = game.connect_diagonal(board, player)
        expect(result).to eq(false)
      end
    end
  end

  describe '#connect_horizontal' do
    context 'when there is winning combination horizontally' do
      let(:token) { game.black_token }
      before do
        board = game.board
        board[0][0..3] = token, token, token, token
      end
      it 'returns true' do
        player = { name: 'Jane', token: token }
        board = game.board
        result = game.connect_horizontal(board, player)
        expect(result).to eq(true)
      end
    end
  end
end
