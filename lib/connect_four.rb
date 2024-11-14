class ConnectFour
  attr_accessor :board, :white_token, :black_token

  def initialize
    @board = Array.new(6) { Array.new(7) { ' ' } }
    @white_token = "\u25CF"
    @black_token = "\u25CB"
    @player_one = { name: nil, token: @white_token }
    @player_two = { name: nil, token: @black_token }
  end

  def insert_token(token, column)
    bottom_row = 5
    loop do
      if bottom_row.negative?
        puts 'This column is full. Please choose a different one.'
        break
      elsif @board[bottom_row][column - 1] == ' '
        @board[bottom_row][column - 1] = token
        break
      else
        bottom_row -= 1
      end
    end
  end

  def connect_diagonal(board, player)
    token = player[:token]
    rows = board.length
    cols = board[0].length

    # Check for diagonals from top-left to bottom-right
    (0..rows - 4).each do |row|
      (0..cols - 4).each do |col|
        if (0..3).all? { |i| board[row + i][col + i] == token }
          puts "Congratulations #{player[:name]}! You win!"
          return true
        end
      end
    end

    # Check for diagonals from bottom-left to top-right
    (3...rows).each do |row|
      (0..cols - 4).each do |col|
        if (0..3).all? { |i| board[row - i][col + i] == token }
          puts "Congratulations #{player[:name]}! You win!"
          return true
        end
      end
    end

    false
  end

  def connect_horizontal(board, player)
    tokens = Array.new(4, nil)
    start_point = [0, 0]
    end_point = [0, board[0].length - 1]
    traverse = [0, 0]

    loop do
      tokens.shift
      tokens.push(board[traverse[0]][traverse[1]])

      if tokens.uniq.join == player[:token] && !tokens.include?(nil)
        current_board
        puts "Congratulations #{player[:name]}! You win!"
        return true
      end

      if traverse == end_point
        start_point[0] += 1
        end_point[0] += 1
        traverse = start_point.dup
        tokens = Array.new(4, nil)
      else
        traverse[1] += 1
      end

      break if end_point == [board.length, board[0].length - 1]
    end
    false
  end

  def connect_vertical(board, player)
    tokens = Array.new(4, nil)
    start_point = [0, 0]
    end_point = [board.length - 1, 0]
    traverse = [0, 0]

    loop do
      tokens.shift
      tokens.push(board[traverse[0]][traverse[1]])

      if tokens.uniq.join == player[:token] && !tokens.include?(nil)
        current_board
        puts "Congratulations #{player[:name]}! You win!"
        return true
      end

      if traverse == end_point
        start_point[1] += 1
        end_point[1] += 1
        traverse = start_point.dup
        tokens = Array.new(4, nil)
      else
        traverse[0] += 1
      end

      break if end_point == [board.length - 1, board[0].length]
    end
    false
  end

  def pick_column(player)
    puts "Hi, #{player[:name]}. Please choose a column from 1 to #{@board[0].length}"
    loop do
      input = gets.chomp
      unless input.to_i.between?(1, @board[0].length)
        puts 'Invalid input.'
        redo
      end

      return input.to_i
    end
  end

  def board_full?(board = @board)
    full = false
    board.each do |row|
      full = row.include?(' ') ? false : true
    end

    puts 'Oh no! The board is full, and nobody won' if full

    full
  end

  def win?(board, player)
    if connect_diagonal(board, player) ||
       connect_horizontal(board, player) ||
       connect_vertical(board, player)
      true
    else
      false
    end
  end

  def play_game(board = @board)
    current_player = @player_one
    player_input
    loop do
      print_board
      insert_token(current_player[:token], pick_column(current_player))
      break if win?(board, current_player)
      break if board_full?

      current_player = current_player == @player_one ? @player_two : @player_one
    end
  end

  private

  def player_input
    puts "Welcome! Let's play Connect Four"
    puts 'Please put your name for player one'
    @player_one[:name] = gets.chomp
    puts 'Please put your name for player two'
    @player_two[:name] = gets.chomp
    puts "Thanks #{@player_one[:name]} and #{@player_two[:name]}. Now, let's start playing!"
  end

  def current_board
    @board.each_with_index do |row, index|
      print "#{index + 1} "
      puts row.map { |cell| "| #{cell} " }.join + '|'
      print '  '
      puts '-' * ((row.length * 4) + 1)
    end
  end

  def print_board
    puts "\nPick one from the column below\n\n"
    print "    #{%w[1 2 3 4 5 6 7].join('   ')}\n"
    current_board
  end
end
