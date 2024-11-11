class ConnectFour
  attr_accessor :board, :white_token, :black_token

  def initialize
    @board = Array.new(6) { Array.new(7) { ' ' } }
    @white_token = "\u25CF"
    @black_token = "\u25CB"
  end

  def insert_token(token, column)
    @board[5][column - 1] = token
  end

  def print_board
    puts "\nPick one from the column below\n\n"
    print "    #{%w[1 2 3 4 5 6 7].join('   ')}\n"
    @board.each_with_index do |row, index|
      print "#{index + 1} "
      puts row.map { |cell| "| #{cell} " }.join + '|'
      print '  '
      puts '-' * ((row.length * 4) + 1)
    end
  end
end
