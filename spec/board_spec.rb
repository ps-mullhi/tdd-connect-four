require_relative '../lib/board.rb'
require_relative '../lib/spot_type.rb'

describe Board do
  subject(:board) {described_class.new}
  let(:board_spots) {board.instance_variable_get(:@board_spots)}

  describe '#board_full?' do
    context 'when the board is newly made' do
      it 'should return false' do
        expect(board).not_to be_full
      end
    end

    context 'when the board is partly full' do
      before do
        board_spots.flatten.shuffle.take(10).each_with_index do |spot, i|
          spot.instance_variable_set(:@value, SpotType::YELLOW_TOKEN) if i.even?
          spot.instance_variable_set(:@value, SpotType::RED_TOKEN) if i.odd?
        end
      end
      
      it 'should return false' do
        expect(board).not_to be_full
      end
    end

    context 'when the board is full' do
      before do
        board_spots.each do |row| 
          row.each_with_index do |spot, i|
            spot.instance_variable_set(:@value, SpotType::YELLOW_TOKEN) if i.even?
            spot.instance_variable_set(:@value, SpotType::RED_TOKEN) if i.odd?
          end
        end
      end
      
      it 'should return true' do
        expect(board).to be_full
      end
    end
  end
end