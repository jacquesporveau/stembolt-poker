class Game
  require_relative './card'
  require_relative './player'
  require 'byebug'

  attr_accessor :players

  def initialize
    @players = []
  end

  def start_game(number_of_players)

    number_of_players.times do |i|
      player_name = get_players_name(i + 1)
      players << Player.new(player_name)
    end

    players.each do |player| 
      player.draw_hand
      evaluated_hand = player.evaluate_hand

      puts "#{player.name} has #{evaluated_hand[:title]} with the hand #{evaluated_hand[:pretty_hand]}"
    end
  end

  def find_winner
    winning_hand = 0
    winning_hand_name = nil
    winner = nil
    kicker = 0

    players.each do |player|
      evaluated_hand = player.evaluate_hand
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
    winner
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
