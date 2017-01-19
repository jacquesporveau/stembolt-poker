require 'rubygems'
require 'bundler/setup'
require 'byebug'

require_relative 'lib/card'
require_relative 'lib/player'

def greeting
  puts 'Welcome to Stembolt poker.'
  puts 'How many players will be playing?'
  gets.chomp.to_i
end

def get_players_name(num)
  puts "Please enter name for player #{num}"
  gets.chomp
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

def draw_card(player)
  value = rand(2..14)
  suit = rand(1..4)

  player.hand << Card.new(value, suit)
end

def draw_hand(player)
  5.times { draw_card(player) }
end

#
# HANDS
#

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
  return false unless one_pair?(hand)
  hand_by_card_val = hand.map { |card| card.value }

  hand_by_card_val.each do |card|
    return true if (hand_by_card_val - [card, card, card]).length == 2
  end
  false
end

def two_pairs?(hand)
  return false unless one_pair?(hand)
  hand.map { |card| card.value }.uniq.length == 3
end

def one_pair?(hand)
  hand_by_card_val = hand.map { |card| card.value }.uniq.length == 4
end

def high_card(hand)
  convert_to_facecard(hand_by_card_val = hand.map { |card| card.value }.max)
end



def evaluate_hand(hand)
  sorted_hand = hand.sort_by { |card| card.value }
  pretty_hand = sorted_hand.map do |card|
    convert_to_facecard(card.value) + convert_to_suit(card.suit)
  end

  evaluated_hand = {
    hand: sorted_hand,
    title: '',
    pretty_hand: pretty_hand
  }

  case
  when royal_flush?(sorted_hand)
    evaluated_hand[:title] = 'Royal Flush'

  when straight_flush?(sorted_hand)
    evaluated_hand[:title] = 'Straight Flush'

  when four_of_a_kind?(sorted_hand)
    evaluated_hand[:title] = 'Four of a Kind'

  when full_house?(sorted_hand)
    evaluated_hand[:title] = 'Full House'

  when flush?(sorted_hand)
    evaluated_hand[:title] = 'Flush'

  when straight?(sorted_hand)
    evaluated_hand[:title] = 'Straight'

  when three_of_a_kind?(sorted_hand)
    evaluated_hand[:title] = 'Three of a Kind'

  when two_pairs?(sorted_hand)
    evaluated_hand[:title] = 'Two Pairs'

  when one_pair?(sorted_hand)
    evaluated_hand[:title] = 'One Pair'

  else
    evaluated_hand[:title] = "High Card #{high_card(sorted_hand)}"
  end
  evaluated_hand
end

#
# GAME FLOW
#

def start_game(number_of_players)
  players = []

  number_of_players.times do |i|
    player_name = get_players_name(i + 1)
    players << Player.new(player_name)
  end

  players.each do |player| 
    draw_hand(player)
    evaluated_hand = evaluate_hand(player.hand)
    puts "#{player.name} has a #{evaluated_hand[:title]} with the hand #{evaluated_hand[:pretty_hand]}"
  end
end

number_of_players = greeting
start_game(number_of_players)
