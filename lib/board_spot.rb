require_relative 'spot_type.rb'

class BoardSpot

  def initialize(type)
    @value = type
  end

  def empty?
    @value == SpotType::EMPTY
  end
end