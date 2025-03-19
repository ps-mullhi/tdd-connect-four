require_relative '../lib/board_spot.rb'
require_relative '../lib/spot_type.rb'

describe BoardSpot do
  describe '#empty?' do
    context 'when the spot is occupied by a yellow token' do
      subject(:yellow_spot) {described_class.new(SpotType::YELLOW_TOKEN)}
      
      it 'should return false' do
        expect(yellow_spot).not_to be_empty
      end
    end

    context 'when the spot is occupied by a red token' do
      subject(:red_spot) {described_class.new(SpotType::RED_TOKEN)}
      
      it 'should return false' do
        expect(red_spot).not_to be_empty
      end
    end

    context 'when the spot is empty' do
      subject(:empty_spot) {described_class.new(SpotType::EMPTY)}
      
      it 'should return false' do
        expect(empty_spot).to be_empty
      end
    end
  end
end