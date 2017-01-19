require 'rubygems'
require 'bundler/setup'
require 'byebug'

require_relative 'lib/card'
require_relative 'lib/player'

#
# GAME HELPERS
#

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
# GAME FLOW
#

def start_game(number_of_players)
  players = []
  winning_hand = 0
  winning_hand_name = nil
  winner = nil
  kicker = 0

  number_of_players.times do |i|
    player_name = get_players_name(i + 1)
    players << Player.new(player_name)
  end

  players.each do |player| 
    draw_hand(player)
    evaluated_hand = player.evaluate_hand

    puts "#{player.name} has #{evaluated_hand[:title]} with the hand #{evaluated_hand[:pretty_hand]}"

    if evaluated_hand[:hand_signifigance] == winning_hand
      if evaluated_hand[:high_card] > kicker
        winner = player.name 
        kicker = evaluated_hand[:high_card]
        winning_hand = evaluated_hand[:hand_signifigance]
        winning_hand_name = evaluated_hand[:title]
      end
    end

    if evaluated_hand[:hand_signifigance] > winning_hand
      winner = player.name
      kicker = evaluated_hand[:high_card]
      winning_hand = evaluated_hand[:hand_signifigance]
      winning_hand_name = evaluated_hand[:title]
    end
  end
  puts "Winner was #{winner} with the hand: #{winning_hand_name} with a #{convert_to_facecard(kicker)} kicker"
end

number_of_players = greeting
start_game(number_of_players)
