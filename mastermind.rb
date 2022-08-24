module Validate
  POSSIBLE_COLORS = %w[red blue green purple yellow orange].freeze
end

class ComputerCodemaker
  include Validate

  attr_reader :hidden_code, :colors_in_hidden_code

  def initialize
    # Randomly select an assortment of the possible colors to choose from to
    # create the code that is to be decoded by the player
    @hidden_code = Array.new(4).map do
      POSSIBLE_COLORS.sample
    end
    @colors_in_hidden_code = count_number_of_colors_in_hidden_code
  end

  private

  def count_number_of_colors_in_hidden_code
    hidden_code.reduce(Hash.new(0)) do |colors_hash, color|
      colors_hash[color] += 1
      colors_hash
    end
  end
end

class PlayerCodebreaker
  include Validate

  def initialize
    @player_guess = nil
  end

  def player_guess
    take_player_input
    @player_guess
  end

  private

  def take_player_input
    puts "The possible choices are #{POSSIBLE_COLORS}"
    puts 'Enter your guess (the name of the four colors, each separated by a space):'
    @player_guess = gets.chomp.split
  end
end

computer = ComputerCodemaker.new
puts "The code is #{computer.hidden_code}"
puts "\n"
puts "The number of each color in the code is #{computer.colors_in_hidden_code}"
puts "\n"
player = PlayerCodebreaker.new
puts "Player guess is #{player.player_guess}"
puts "\n"
