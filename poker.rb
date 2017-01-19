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
  end
end

def convert_to_suit(num)
  case num
  when 1
    'hearts'
  when 2
    'diamonds'
  when 3
    'spades'
  when 4
    'clubs'
  end
end

def draw_card(player)
  value = rand(2..14)
  suit = convert_to_suit(rand(1..4))

  player.hand << Card.new(value, suit)
end

def draw_hand(player)
  5.times { draw_card(player) }
end

#
# HANDS
#

def royal_flush?(hand)
  byebug
  return false unless flush?(hand) && straight?(hand)
  hand_by_card_value = hand.map { |card| card.value }

  (hand_by_card_value & [10, 11, 12, 13, 14]).length == 5
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



def evaluate_hand(hand)
  sorted_hand = hand.sort_by { |card| card.value }
  royal_flush?(sorted_hand)
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
    player.hand = evaluate_hand(player.hand)
  end
end

number_of_players = greeting
start_game(number_of_players)
