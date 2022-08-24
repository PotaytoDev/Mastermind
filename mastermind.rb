module Validate
  POSSIBLE_COLORS = %w[red blue green purple yellow orange].freeze
end

class ComputerCodemaker
  include Validate

  attr_reader :hidden_code

  def initialize
    # Randomly select an assortment of the possible colors to choose from to
    # create the code that is to be decoded by the player
    @hidden_code = Array.new(4).map do
      POSSIBLE_COLORS.sample
    end
  end

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
    puts "\n"
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

  def play_game
    player = PlayerCodebreaker.new
    computer = ComputerCodemaker.new
    hidden_code = computer.hidden_code
    number_of_guesses = 12
    player_has_won = false

    number_of_guesses.times do |current_turn|
      puts '--------------------------------------------------------------'
      puts "\nTurn #{current_turn + 1}"
      puts "\n"
      player_guess = player.player_guess
      colors_hash = computer.count_number_of_colors_in_hidden_code

      feedback = compare_player_guess_with_code(player_guess, hidden_code, colors_hash)

      puts "\n"
      puts '==============================================================='
      puts "Exact matches: #{feedback[0]}"
      puts "Correct color, but wrong position: #{feedback[1]}"
      puts '==============================================================='
      puts "\n"

      if feedback[0] == 4
        puts 'You win!'
        player_has_won = true
        break
      end
    end

    puts "You didn't crack the code!" unless player_has_won
    puts "\n"
    puts 'The hidden code was:'
    p hidden_code
  end
end

mastermind = GameLogic.new
mastermind.play_game
