class Code

  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(chars)
    chars.all? { |char| POSSIBLE_PEGS.include?(char.upcase)}
  end

  def initialize(chars)
    raise 'invalid pegs' if !Code.valid_pegs?(chars)
    @pegs = chars.map(&:upcase)
  end

  def self.random(length)
    pegs = Array.new(length) { POSSIBLE_PEGS.keys.sample}
    Code.new(pegs)
  end

  def self.from_string(pegs)
    Code.new(pegs.split(""))
  end

  def [](index)
    @pegs[index]
  end

  def ==(another)
    self.length == another.length && self.pegs == another.pegs
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    (0...guess.length).count { |i| guess[i] == pegs[i]}
  end

  def num_near_matches(guess)
    (0...guess.length).count { |i| @pegs.include?(guess[i])} - num_exact_matches(guess)
  end
end
