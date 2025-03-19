require_relative './board_spot.rb'
require_relative './spot_type.rb'

class Board

  def initialize
    @board_spots = Array.new(6) {Array.new(7) {BoardSpot.new(SpotType::EMPTY)}}
  end

  def full?
    @board_spots.all? {|row| row.all? {|spot| spot.empty? == false}}
  end
end