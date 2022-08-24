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

class GameLogic
  def compare_player_guess_with_code(player_guess_array, hidden_code, colors_left_to_match)
    exact_matches = 0
    correct_color_but_wrong_position = 0
    exact_matches_indices = []

    # Check to see how many of the colors in player's guess are in the exact
    # position as those in the hidden code
    4.times do |index|
      color_guess = player_guess_array[index]
      hidden_code_color = hidden_code[index]

      if color_guess == hidden_code_color
        exact_matches += 1
        colors_left_to_match[color_guess] -= 1
        exact_matches_indices.push(index)
      end
    end

    indices_that_are_not_exact_match = (0..3).to_a - exact_matches_indices

    # Check to see how many of the colors in player's guess are correct, but
    # in the wrong position in comparison to those in hidden code
    indices_that_are_not_exact_match.each do |index|
      color_guess = player_guess_array[index]

      if hidden_code.include?(color_guess) && colors_left_to_match[color_guess].positive?
        colors_left_to_match[color_guess] -= 1
        correct_color_but_wrong_position += 1
      end
    end

    [exact_matches, correct_color_but_wrong_position]
  end
end

player = PlayerCodebreaker.new
computer = ComputerCodemaker.new
code = computer.hidden_code
colors_in_code = computer.colors_in_hidden_code
player = PlayerCodebreaker.new
player_guess = player.player_guess
puts "The code is #{code}"
puts "\n"
puts "The number of each color in the code is #{colors_in_code}"
puts "\n"
puts "Player guess is #{player_guess}"
puts "\n"
game = GameLogic.new
p game.compare_player_guess_with_code(player_guess, code, colors_in_code)
