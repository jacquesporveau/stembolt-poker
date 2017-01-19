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

def draw_card

end

def start_game(number_of_players)
  players = []

  number_of_players.times do |i|
    player_name = get_players_name(i + 1)
    players << Player.new(player_name)
  end
  byebug
end

number_of_players = greeting
start_game(number_of_players)
