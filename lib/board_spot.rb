require_relative 'spot_type.rb'

class BoardSpot
  attr_accessor :value

  def initialize(type)
    @value = type
  end

  def empty?
    @value == SpotType::EMPTY
  end
end