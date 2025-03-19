require_relative '../lib/board.rb'
require_relative '../lib/spot_type.rb'

describe Board do
  subject(:board) {described_class.new}
  let(:board_spots) {board.instance_variable_get(:@board_spots)}

  describe '#full?' do
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

  describe '#winner?' do
    context 'when the board is newly made' do
      it 'should return false' do
        expect(board).not_to be_winner
      end
    end

    context 'when the board has some elements, but no one winning' do
      before do
        # set only every second row with elements to ensure no diagonal or vertical wins
        # then alternate within each row to ensure no row wins
        board_spots.each_with_index do |row, i| 
          row.each_with_index do |spot, j|
            if i.even?
              spot.instance_variable_set(:@value, SpotType::YELLOW_TOKEN) if j.even?
              spot.instance_variable_set(:@value, SpotType::RED_TOKEN) if j.odd?
            end
          end
        end
      end
      
      it 'should return false' do
        expect(board).not_to be_winner
      end
    end

    context 'when the board has a winning row using yellow' do
      before do 
        board_spots[1][2].instance_variable_set(:@value, SpotType::YELLOW_TOKEN)
        board_spots[1][3].instance_variable_set(:@value, SpotType::YELLOW_TOKEN)
        board_spots[1][4].instance_variable_set(:@value, SpotType::YELLOW_TOKEN)
        board_spots[1][5].instance_variable_set(:@value, SpotType::YELLOW_TOKEN)
      end

      it 'should return true' do
        expect(board).to be_winner
      end
    end

    context 'when the board has a winning column using red' do
      before do 
        board_spots[2][3].instance_variable_set(:@value, SpotType::RED_TOKEN)
        board_spots[3][3].instance_variable_set(:@value, SpotType::RED_TOKEN)
        board_spots[4][3].instance_variable_set(:@value, SpotType::RED_TOKEN)
        board_spots[5][3].instance_variable_set(:@value, SpotType::RED_TOKEN)
      end

      it 'should return true' do
        expect(board).to be_winner
      end
    end

    context 'when the board has a winning low-to-high diagonal using yellow' do
      before do 
        board_spots[3][3].instance_variable_set(:@value, SpotType::YELLOW_TOKEN)
        board_spots[2][4].instance_variable_set(:@value, SpotType::YELLOW_TOKEN)
        board_spots[1][5].instance_variable_set(:@value, SpotType::YELLOW_TOKEN)
        board_spots[0][6].instance_variable_set(:@value, SpotType::YELLOW_TOKEN)
      end

      it 'should return true' do
        expect(board).to be_winner
      end
    end

    context 'when the board has a winning high-to-low diagonal using red' do
      before do 
        board_spots[0][1].instance_variable_set(:@value, SpotType::RED_TOKEN)
        board_spots[1][2].instance_variable_set(:@value, SpotType::RED_TOKEN)
        board_spots[2][3].instance_variable_set(:@value, SpotType::RED_TOKEN)
        board_spots[3][4].instance_variable_set(:@value, SpotType::RED_TOKEN)
      end

      it 'should return true' do
        expect(board).to be_winner
      end
    end
  end
end