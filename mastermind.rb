module Validate
  POSSIBLE_COLORS = %w[red blue green purple yellow orange].freeze
end

class ComputerCodemaker
  include Validate

  attr_reader :hidden_code

  def initialize
    super

    # Randomly select an assortment of the possible colors to choose from to
    # create the code that is to be decoded by the player
    @hidden_code = Array.new(4).map do
      POSSIBLE_COLORS.sample
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
player = PlayerCodebreaker.new
puts "Player guess is #{player.player_guess}"
