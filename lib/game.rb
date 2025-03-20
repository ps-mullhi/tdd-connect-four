require_relative './player.rb'
require_relative './console_ui.rb'
require_relative './board.rb'

class Game

  def initialize(board = Board.new)
    @board = board
    @players = []
    @active_player = nil
    @non_active_player = nil 
  end

  def play 
    loop do   
      @board.print_board
      token = @active_player.token == 0 ? 'Yellow' : 'Red'
      puts "You are #{token}"
      player_move
      puts `clear`

      if game_over?
        print_results(@active_player.name)
        break
      end

      switch_active_player
    end

  end

  def setup_players
    player_one = Player.new(ConsoleUI.get_player_name, SpotType::YELLOW_TOKEN)
    ConsoleUI.clear_after_input_received('Press anything to setup next player...')
    player_two = Player.new(ConsoleUI.get_player_name, SpotType::RED_TOKEN)
    ConsoleUI.clear_after_input_received('Press anything to finish setup...')

    @active_player = player_one
    @non_active_player = player_two

    [player_one, player_two]
  end

  def game_over?
    return true if @board.winner? || @board.full?
    
    false
  end

  def switch_active_player
    @active_player, @non_active_player = @non_active_player, @active_player
  end

  def player_move
    move = 0

    loop do 
      move = ConsoleUI.get_player_move(@active_player.name)
      move
      begin 
        is_column_full = @board.column_full?(move)
        break unless is_column_full
      rescue IndexError
        puts "That's not a valid column (1-7 only)"
        next
      end
    end

    @board.drop_token(move, @active_player.token)
  end
end

def print_results(name)
  if @board.full? && @board.winner? == false
    puts "Draw"
  else
    puts "#{name} wins!"
  end
end