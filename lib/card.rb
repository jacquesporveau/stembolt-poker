class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value.to_i
    @suit = suit
  end
end
