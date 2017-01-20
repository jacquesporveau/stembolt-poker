class Player
  attr_reader :name
  attr_accessor :hand

  def initialize(name)
    @name = name.capitalize
    @hand = []
  end

  def evaluate_hand
    sorted_hand = hand.sort_by { |card| card.value }
    pretty_hand = sorted_hand.map do |card|
      convert_to_facecard(card.value) + convert_to_suit(card.suit)
    end

    evaluated_hand = {
      hand: sorted_hand,
      title: '',
      pretty_hand: pretty_hand,
      hand_signifigance: 1,
      high_card: hand.map { |card| card.value }.max
    }

    case
    when royal_flush?(sorted_hand)
      evaluated_hand[:title] = 'Royal Flush'
      evaluated_hand[:hand_signifigance] = 10

    when straight_flush?(sorted_hand)
      evaluated_hand[:title] = 'Straight Flush'
      evaluated_hand[:hand_signifigance] = 9

    when four_of_a_kind?(sorted_hand)
      evaluated_hand[:title] = 'Four of a Kind'
      evaluated_hand[:hand_signifigance] = 8

    when full_house?(sorted_hand)
      evaluated_hand[:title] = 'Full House'
      evaluated_hand[:hand_signifigance] = 7

    when flush?(sorted_hand)
      evaluated_hand[:title] = 'Flush'
      evaluated_hand[:hand_signifigance] = 6

    when straight?(sorted_hand)
      evaluated_hand[:title] = 'Straight'
      evaluated_hand[:hand_signifigance] = 5

    when three_of_a_kind?(sorted_hand)
      evaluated_hand[:title] = 'Three of a Kind'
      evaluated_hand[:hand_signifigance] = 4

    when two_pairs?(sorted_hand)
      evaluated_hand[:title] = 'Two Pairs'
      evaluated_hand[:hand_signifigance] = 3

    when one_pair?(sorted_hand)
      evaluated_hand[:title] = 'One Pair'
      evaluated_hand[:hand_signifigance] = 2

    else
      evaluated_hand[:title] = "High Card #{high_card(sorted_hand)}"
      evaluated_hand[:hand_signifigance] = 1
    end
    evaluated_hand
  end

  def royal_flush?(hand)
    return false unless flush?(hand) && straight?(hand)
    hand_by_card_val = hand.map { |card| card.value }

    (hand_by_card_val & [10, 11, 12, 13, 14]).length == 5
  end

  def straight_flush?(hand)
    flush?(hand) && straight?(hand)
  end

  def four_of_a_kind?(hand)
    hand.map { |card| card.value }.uniq.length == 2
  end

  def full_house?(hand)
    three_of_a_kind?(hand) && one_pair?(hand)
  end

  def flush?(hand)
    hand_by_card_suit = hand.map { |card| card.suit }
    previous_card = hand_by_card_suit[0]

    hand_by_card_suit[1..4].each do |card|
      return false if card != previous_card
      previous_card = card
    end
    true
  end

  def straight?(hand)
    hand_by_card_val = hand.map { |card| card.value }
    previous_card = hand_by_card_val[0]

    hand_by_card_val[1..4].each do |card|
      return false if card - 1 != previous_card
      previous_card = card
    end
    true
  end

  def three_of_a_kind?(hand)
    hand_by_card_val = hand.map { |card| card.value }
    hand_by_card_val.detect{ |e| hand_by_card_val.count(e) > 2 } != nil
  end

  def two_pairs?(hand)
    return false unless one_pair?(hand)
    hand.map { |card| card.value }.uniq.length == 3
  end

  def one_pair?(hand)
    hand_by_card_val = hand.map { |card| card.value }
    hand_by_card_val.detect{ |e| hand_by_card_val.count(e) > 1 } != nil
  end

  def high_card(hand)
    convert_to_facecard(hand.map { |card| card.value }.max)
  end

  def draw_card
    value = rand(2..14)
    suit = rand(1..4)

    hand << Card.new(value, suit)
  end

  def draw_hand
    5.times { draw_card }
  end

  def convert_to_facecard(num)
    case num
    when 11
      'J'
    when 12
      'Q'
    when 13
      'K'
    when 14
      'A'
    else
      num.to_s
    end
  end

  def convert_to_suit(num)
    case num
    when 1
      'H'
    when 2
      'D'
    when 3
      'S'
    when 4
      'C'
    else
      num.to_s
    end
  end
end
