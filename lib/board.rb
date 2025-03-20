require_relative './board_spot.rb'
require_relative './spot_type.rb'

class Board

  def initialize
    @board_spots = Array.new(6) {Array.new(7) {BoardSpot.new(SpotType::EMPTY)}}
  end

  def full?
    @board_spots.all? {|row| row.all? {|spot| spot.empty? == false}}
  end

  def winner?
    return true if 
      self.winning_row? ||
      self.winning_column? ||
      self.winning_high_to_low_diagonal? ||
      self.winning_low_to_high_diagonal?

    false
  end

  def column_full?(col_index)
    raise IndexError unless col_index.between?(0, 6)

    column = Array.new
    @board_spots.each do |row|
      column << row[col_index]
    end

    return false if column.any? {|spot| spot.value == SpotType::EMPTY}

    true
  end

  def drop_token(col_index, token)
    (5).downto(0) do |row_index|
      if @board_spots[row_index][col_index].value == SpotType::EMPTY
        @board_spots[row_index][col_index].value = token
        return
      end
    end
  end

  def print_board 
    puts "1 2 3 4 5 6 7"
    puts "---------------"
    @board_spots.each do |row|
      row.each do |spot|
        case spot.value
        when SpotType::YELLOW_TOKEN then print "Y"
        when SpotType::RED_TOKEN then print "R"
        when SpotType::EMPTY then print "_"
        else "ERROR"
        end
        print " "
      end
      puts
    end
  end 

  private

  def winning_row?
    @board_spots.each do |row|
      row.each_cons(4) do |four_in_a_row|
        return true if four_in_a_row.all? {|spot| spot.value == SpotType::YELLOW_TOKEN} ||
                       four_in_a_row.all? {|spot| spot.value == SpotType::RED_TOKEN}
      end
    end

    false
  end

  def winning_column?
    (0..6).each do |col_index|
      column = Array.new
      @board_spots.each do |row|
        column << row[col_index]
      end

      column.each_cons(4) do |four_in_a_row|
        return true if four_in_a_row.all? {|spot| spot.value == SpotType::YELLOW_TOKEN} ||
                       four_in_a_row.all? {|spot| spot.value == SpotType::RED_TOKEN}
      end
    end
    
    false
  end

  def winning_high_to_low_diagonal?
    (0..2).each do |row_index|
      (0..3).each do |col_index|
        diagonal = (0..3).map {|offset| @board_spots[row_index + offset][col_index + offset]}
        return true if diagonal.all? {|spot| spot.value == SpotType::YELLOW_TOKEN} ||
                       diagonal.all? {|spot| spot.value == SpotType::RED_TOKEN}
      end
    end

    false
  end

  def winning_low_to_high_diagonal?
    (3..5).each do |row_index|
      (0..3).each do |col_index|
        diagonal = (0..3).map {|offset| @board_spots[row_index - offset][col_index + offset]}
        return true if diagonal.all? {|spot| spot.value == SpotType::YELLOW_TOKEN} ||
                       diagonal.all? {|spot| spot.value == SpotType::RED_TOKEN}
      end
    end
    
    false
  end
end