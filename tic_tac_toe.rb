class Game
  
    @@turn_count = 1
    @@winner = ''
  
    def initialize
      puts 'Player 1, enter your name!'
      @player_one_name = gets.chomp
      puts 'Player 2, enter your name!'
      @player_two_name = gets.chomp
      @board = Array.new(3) { Array.new(3, '_') }
    end
  
    # Display the current state of the board
    def display_board
      puts "\n"
      @board.each { |row| puts row.join(' | ') }
      puts "\n"
    end
  
    def player_turn(turn)
      if turn.odd?
        player_choice(@player_one_name, '0')
      else
        player_choice(@player_two_name, 'X')
      end
    end
  
    def player_choice(player, symbol)
      puts "#{player}, please enter your coordinates separated by a space (e.g., '1 2')"
      input = gets.chomp
      input_array = input.split
      coord_one = input_array[0].to_i
      coord_two = input_array[1].to_i
  
      # Loop until the user enters valid coordinates for an empty space on the grid
      until input.match(/\d+\s\d+/) &&
            coord_one.between?(0, 2) &&
            coord_two.between?(0, 2) &&
            @board[coord_one][coord_two] == '_'
        puts "Please enter valid coordinates for an empty space in the grid (e.g., '1 2')"
        input = gets.chomp
        input_array = input.split
        coord_one = input_array[0].to_i
        coord_two = input_array[1].to_i
      end
      add_to_board(coord_one, coord_two, symbol)
    end
  
    def add_to_board(coord_one, coord_two, symbol)
      @board[coord_one][coord_two] = symbol
      @@turn_count += 1
    end
  
    # Checking for three in a row
    def three_in_a_row(symbol)
      @board.each do |row|
        return true if row.all? { |cell| cell == symbol }
      end
      false
    end
  
    # Checking for three in a column
    def three_in_a_column(symbol)
      @board.transpose.each do |col|
        return true if col.all? { |cell| cell == symbol }
      end
      false
    end
  
    # Checking for three diagonally
    def three_diagonal(symbol)
      left_diagonal = (0..2).map { |i| @board[i][i] }
      right_diagonal = (0..2).map { |i| @board[i][2 - i] }
      return true if left_diagonal.all? { |cell| cell == symbol }
      return true if right_diagonal.all? { |cell| cell == symbol }
      false
    end
  
    # Checking for a winner
    def winner(symbol)
      three_in_a_row(symbol) || three_in_a_column(symbol) || three_diagonal(symbol)
    end
  
    def play
      until @@turn_count > 9
        display_board
        player_turn(@@turn_count)
        display_board
        if winner('X')
          puts "#{@player_two_name} wins!"
          break
        elsif winner('0')
          puts "#{@player_one_name} wins!"
          break
        elsif @@turn_count > 9
          puts "It's a draw!"
        end
      end
    end
  end
  
  # Create a new game and start playing
  game = Game.new
  game.play
  