require_relative '../lib/game.rb'
require_relative '../lib/board.rb'

describe Game do

  describe '#setup_players' do
    subject(:game) {described_class.new}
    
    context 'when all inputs follow happy path' do
      before do 
        allow_any_instance_of(Kernel).to receive(:gets).and_return('Sarah', 'Y', '', 'Mason', 'Y', '')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'returns the two setup players' do
        players = game.setup_players
        expect(players[0].name).to eql('Sarah')
        expect(players[1].name).to eql('Mason')
      end
    end

    context 'when each user requires two tries' do
      before do 
        allow_any_instance_of(Kernel).to receive(:gets).and_return(
          'Jo', 'N', 'Joe', 'Y', '',
          'Mie', 'N', 'Mike', 'Y', '')
        allow_any_instance_of(Kernel).to receive(:print)
        allow_any_instance_of(Kernel).to receive(:puts)
      end

      it 'returns the re-entered names of each player' do
        players = game.setup_players
        expect(players[0].name).to eql('Joe')
        expect(players[1].name).to eql('Mike')
      end
    end
  end

  describe '#game_over?' do
    let(:game_over_board) {instance_double("Board")}
    subject(:game_over_game) {described_class.new(game_over_board)}

    context 'when there is a winner' do
      before do
        allow(game_over_board).to receive(:winner?).and_return(true)   
        allow(game_over_board).to receive(:full?).and_return(false)  
      end

      it 'game should end' do
        expect(game_over_game).to be_game_over
      end
    end

    context 'when the board is full' do
      before do
        allow(game_over_board).to receive(:full?).and_return(true)
        allow(game_over_board).to receive(:winner?).and_return(false)
      end

      it 'game should end' do
        expect(game_over_game).to be_game_over
      end
    end
  end

  describe '#switch_active_player' do 
    subject(:game) {described_class.new}
    let(:player_one) {instance_double('Player')}
    let(:player_two) {instance_double('Player')}
    
    before do
      game.instance_variable_set(:@active_player, player_one)
      game.instance_variable_set(:@non_active_player, player_two)
    end
    
    it 'should swap the two players' do 
      game.switch_active_player

      expect(game.instance_variable_get(:@active_player)).to equal(player_two)
      expect(game.instance_variable_get(:@non_active_player)).to equal(player_one)
    end
  end
end