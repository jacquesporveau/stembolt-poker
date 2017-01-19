require "spec_helper"
require "player"
require 'byebug'

RSpec.describe Player, type: :model do
  let (:stable_player) { Player.new('Dennis') }
  let (:format_player) { Player.new('cLARke') }

  describe 'attributes' do
    it 'has a readable name attribute' do
      expect(stable_player.name).to eq('Dennis')
    end

    it 'has a hand attribute that defaults to an empty array' do
      expect(stable_player.hand).to eq([])
    end

    it 'formats the name attribute to a capitalized string' do
      expect(format_player.name).to eq('Clarke')
    end
  end
end
