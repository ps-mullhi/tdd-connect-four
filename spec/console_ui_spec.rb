require_relative '../lib/console_ui.rb'

describe ConsoleUI do 
  describe '#get_player_name' do
    context 'when they input their name and approve it first try' do
      before do 
        allow_any_instance_of(Kernel).to receive(:gets).and_return('Mike', 'Y')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'should return name and only run once' do
        expect(ConsoleUI.get_player_name).to eql('Mike')
      end
    end

    context 'when they input their name, disapprove, re-enter and approve' do
      before do 
        allow_any_instance_of(Kernel).to receive(:gets).and_return('JAon', 'n', 'Jason', 'Y')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'should puts error once, and then return name' do
        expect(ConsoleUI).to receive(:puts).with('Confirmation fail, input again!').once
        expect(ConsoleUI).to receive(:puts).with('Jason confirmed.').once
        expect(ConsoleUI.get_player_name).to eql('Jason')
      end
    end

    context 'when they input name correctly on fourth try' do
      before do 
        allow_any_instance_of(Kernel).to receive(:gets).and_return('JAon', 'n', 'Jason', 'n', 'Mike', 'n', 'Timothy', 'Y')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'should puts error once, and then return name' do
        expect(ConsoleUI).to receive(:puts).with('Confirmation fail, input again!').exactly(3).times
        expect(ConsoleUI).to receive(:puts).with('Timothy confirmed.').once
        expect(ConsoleUI.get_player_name).to eql('Timothy')
      end
    end
  end

  describe '#get_player_move' do
    context 'when they enter a valid input (1-7 for which column)' do
      before do
        allow_any_instance_of(Kernel).to receive(:gets).and_return('3')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'should return that index minus 1' do
        expect(ConsoleUI.get_player_move('Alice')).to eql(2)
      end
    end

    context 'when they enter an invalid number, then a valid input' do
      before do
        allow_any_instance_of(Kernel).to receive(:gets).and_return('0', '1')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'should return that index minus 1' do
        expect(ConsoleUI.get_player_move('Jordan')).to eql(0)
      end
    end

    context 'when they enter a letter, then a valid input' do
      before do
        allow_any_instance_of(Kernel).to receive(:gets).and_return('a', '7')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'should return that index minus 1' do
        expect(ConsoleUI.get_player_move('Mitch')).to eql(6)
      end
    end
  end

end