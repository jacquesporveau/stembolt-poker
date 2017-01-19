class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name.capitalize
    @hand = []
  end
end
