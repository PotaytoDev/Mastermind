class Codemaker
  attr_reader :possible_colors

  def initialize
    @possible_colors = %w[red blue green purple yellow orange]
  end
end

class ComputerCodemaker < Codemaker
  attr_reader :hidden_code

  def initialize
    super

    # Randomly select an assortment of the possible colors to choose from to
    # create the code that is to be decoded by the player
    @hidden_code = Array.new(4).map do
      possible_colors.sample
    end
  end
end

class PlayerCodebreaker
  def initialize
    @player_guess = nil
  end

  def take_player_input(possible_colors)
    puts "The possible choices are #{possible_colors}"
    puts 'Enter your guess (the name of the four colors, each separated by a space):'
    @player_guess = gets.chomp.split
  end

  def player_guess(possible_colors)
    take_player_input(possible_colors)
    @player_guess
  end
end

computer = ComputerCodemaker.new
p computer.hidden_code
player = PlayerCodebreaker.new
p player.player_guess(computer.possible_colors)
