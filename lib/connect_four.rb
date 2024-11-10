class ConnectFour
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7) }
    @white_token = "\u26AA"
    @black_token = "\u26AB"
  end

  def insert_token(token, column)
    @board[5][column - 1] = token
  end
end
