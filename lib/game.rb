require_relative './player.rb'
require_relative './console_ui.rb'

class Game

  def initialize(board = Board.new)
    @board = board
    @players = []
    @active_player = nil
    @non_active_player = nil 
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
end