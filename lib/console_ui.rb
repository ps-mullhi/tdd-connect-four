class ConsoleUI
  
  def get_player_name()
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
end