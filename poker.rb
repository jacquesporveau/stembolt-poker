require 'rubygems'
require 'bundler/setup'
require 'byebug'

require_relative 'lib/card'
require_relative 'lib/player'
require_relative 'lib/game'

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

number_of_players = greeting
game = Game.new
game.start_game(number_of_players)
