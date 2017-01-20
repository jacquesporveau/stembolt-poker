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

#
# GAME FLOW
#

number_of_players = greeting
game = Game.new
game.start_game(number_of_players)
game.find_winner
