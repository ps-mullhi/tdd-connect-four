require_relative '../lib/console_ui.rb'

describe ConsoleUI do 
  subject(:console_ui) {described_class.new}  

  describe '#get_player_name' do
    context 'when they input their name and approve it first try' do
      before do 
        allow_any_instance_of(Kernel).to receive(:gets).and_return('Mike', 'Y')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'should return name and only run once' do
        expect(console_ui.get_player_name).to eql('Mike')
      end
    end

    context 'when they input their name, disapprove, re-enter and approve' do
      before do 
        allow_any_instance_of(Kernel).to receive(:gets).and_return('JAon', 'n', 'Jason', 'Y')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'should puts error once, and then return name' do
        expect(console_ui).to receive(:puts).with('Confirmation fail, input again!').once
        expect(console_ui).to receive(:puts).with('Jason confirmed.').once
        expect(console_ui.get_player_name).to eql('Jason')
      end
    end

    context 'when they input name correctly on fourth try' do
      before do 
        allow_any_instance_of(Kernel).to receive(:gets).and_return('JAon', 'n', 'Jason', 'n', 'Mike', 'n', 'Timothy', 'Y')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'should puts error once, and then return name' do
        expect(console_ui).to receive(:puts).with('Confirmation fail, input again!').exactly(3).times
        expect(console_ui).to receive(:puts).with('Timothy confirmed.').once
        expect(console_ui.get_player_name).to eql('Timothy')
      end
    end
  end
end