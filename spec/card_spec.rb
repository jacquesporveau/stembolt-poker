require "spec_helper"
require "card"
require 'byebug'

RSpec.describe Card, type: :model do
  let (:stable_card) { Card.new(7, 1) }
  let (:format_card) { Card.new('7', 1) }

  describe 'attributes' do
    it 'has a readable value attribute' do
      expect(stable_card.value).to eq(7)
    end

    it 'has a readable suit attribute' do
      expect(stable_card.suit).to eq(1)
    end

    it 'formats the value attribute to an integer' do
      expect(format_card.value).to eq(7)
    end
  end
end
