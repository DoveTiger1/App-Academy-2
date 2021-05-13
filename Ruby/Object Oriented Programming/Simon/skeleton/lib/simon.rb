require 'colorize'

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    if !game_over
      round_success_message 
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    seq.each do |color|
      print word_with_color(color)
      sleep(0.7)
      system("clear")
    end
  end

  def require_sequence
    input = gets.chomp.split(' ')
    self.game_over = true if input.length != sequence_length
    (0..sequence_length).each do |i|
      if seq[i] != input[i]
        self.game_over = true
        break
      end
    end
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "You got this round!"
    sleep(0.7)
    system("clear")
  end

  def game_over_message
    puts "You lost! reseting game..."
  end

  def reset_game
    self.sequence_length = 1
    self.game_over = false
    self.seq = []
    sleep(0.7)
    system("clear")
    self.play
  end

  def word_with_color(word)
    if word == 'blue'
      word.colorize(:blue)
    elsif word == 'red'
      word.colorize(:red)
    elsif word == 'green'
      word.colorize(:green)
    elsif word == 'yellow'
      word.colorize(:yellow)
    end
  end
end
