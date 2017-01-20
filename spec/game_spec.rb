require "spec_helper"
require "player"
require 'game'
require 'card'
require 'byebug'

RSpec.describe Game, type: :model do
  let (:player1) { Player.new('Dennis') }
  let (:player2) { Player.new('Clarke') }
  let (:players) { [player1, player2] }
  let (:game) { Game.new }

  let(:highcard) do
    [
      Card.new(2,1),
      Card.new(3,1),
      Card.new(4,1),
      Card.new(7,4),
      Card.new(10,3)
    ]
  end

  let(:pair) do
    [
      Card.new(2,1),
      Card.new(2,1),
      Card.new(4,1),
      Card.new(7,4),
      Card.new(10,3)
    ]
  end

  let(:two_pair) do
    [
      Card.new(2,1),
      Card.new(2,1),
      Card.new(4,1),
      Card.new(4,4),
      Card.new(10,3)
    ]
  end

  let(:three_of_a_kind) do
    [
      Card.new(2,1),
      Card.new(2,1),
      Card.new(2,1),
      Card.new(4,4),
      Card.new(10,3)
    ]
  end

  let(:straight) do
    [
      Card.new(4,1),
      Card.new(3,1),
      Card.new(2,1),
      Card.new(5,4),
      Card.new(6,3)
    ]
  end

  describe '.find_winner' do
    before { players.each { |p| game.players << p } }

    it 'takes a pair over a highcard' do
      player1.hand = highcard
      player2.hand = pair

      expect(game.find_winner).to eq(player2.name)
    end

    it 'takes two pair over a pair' do
      player1.hand = pair
      player2.hand = two_pair

      expect(game.find_winner).to eq(player2.name)
    end

    it 'takes three of a kind over a two pair' do
      player1.hand = two_pair
      player2.hand = three_of_a_kind

      expect(game.find_winner).to eq(player2.name)
    end

    it 'take a straight over three of a kind' do
      player1.hand = three_of_a_kind
      player2.hand = straight

      expect(game.find_winner).to eq(player2.name)
    end
  end
end
