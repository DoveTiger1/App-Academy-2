class Board
  attr_accessor :cups, :name1, :name2

  def initialize(name1, name2)
    @cups = Array.new(14) {Array.new}
    @name1 = name1
    @name2 = name2
    place_stones
  end

  def points_cup(name)
    name == name1 ? 6 : 13
  end

  def opponent_points_cup(name)
    name == name1 ? 13 : 6
  end

  def place_stones
    (0..13).each do |i|
      next if i == 6 || i == 13
      4.times {|j| @cups[i] << :stone}
    end
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' if start_pos > 14 || start_pos < 0
    raise 'Starting cup is empty' if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    other_player_cup = opponent_points_cup(current_player_name)
    stones = @cups[start_pos].length
    @cups[start_pos] = []
    position = start_pos
    i = 0
    while i < stones
      position = (position + 1) % 14
      i = i - 1 if position == other_player_cup
      cups[position] << :stone if position != other_player_cup
      i = i + 1
    end
    render
    next_turn(position, current_player_name)
  end

  def next_turn(ending_cup_idx, player_name)
    if ending_cup_idx == points_cup(player_name)
      return :prompt
    elsif cups[ending_cup_idx].length == 1
      return :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (cups[0..5].all? {|cup| cup.empty?}) || (cups[7..12].all? {|cup| cup.empty?})
  end

  def winner
    if cups[6].length == 6 && cups[13].length == 6
      :draw
    elsif cups[6].length == 6
      name1
    else
      name2
    end
  end
end
