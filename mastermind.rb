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

computer = ComputerCodemaker.new
p computer.hidden_code
