class ConnectFour
  attr_accessor :board, :white_token, :black_token, :player_one, :player_two

  def initialize
    @board = Array.new(6) { Array.new(7) { ' ' } }
    @white_token = "\u25CF"
    @black_token = "\u25CB"
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
    tokens = Array.new(4, nil)
    start_point = [0, 0]
    end_point = [0, 0]
    traverse = [0, 0]

    until end_point[0] == board.length - 1 && end_point[1] == board[0].length - 1
      tokens.shift
      tokens.push(board[traverse[0]][traverse[1]])

      if tokens.uniq.join == player[:token] && !tokens.include?(nil)
        puts "Congratulations #{player[:name]}! You win!"
        return true
      end

      if traverse == end_point
        if start_point[0] < board.length - 1
          start_point[0] += 1
        elsif start_point[0] == board.length - 1
          start_point[1] += 1
        end

        if end_point[1] < board[0].length - 1
          end_point[1] += 1
        elsif end_point[1] == board[0].length - 1
          end_point[0] += 1
        end

        tokens = Array.new(4, nil)
        traverse = start_point.dup
      else
        traverse[0] -= 1 if traverse[0] > end_point[0]
        traverse[1] += 1 if traverse[1] < end_point[1]
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
