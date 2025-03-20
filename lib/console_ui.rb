class ConsoleUI
  
  def self.get_player_name
    name = ''
    loop do
      print('Enter your name: ')
      name = gets.chomp
      print("Confirm your name is #{name}? (Y/N): ")
      confirmation = gets.chomp
      break if confirmation == 'Y'
      puts('Confirmation fail, input again!')
    end
    puts("#{name} confirmed.")
    name
  end

  def self.get_player_move(player_name)
    player_pick = 0
    loop do
      print("Where would you like to go #{player_name}? (#1-7) : ")
      player_pick = gets.chomp.to_i
      break if player_pick.to_i.between?(1,7)
  
      puts('Invalid entry. (Value not between 1-7)')
    end
    proper_index = player_pick - 1

    proper_index
  end

  def self.clear_after_input_received(message)
    print(message)
    gets
    puts(`clear`)
  end
end