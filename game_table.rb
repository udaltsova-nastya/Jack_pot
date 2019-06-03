# frozen_string_literal: true

##
# Stores given cards
class GameTable
  attr_reader :cards

  def initialize
    @cards = []
  end

  def put(new_cards:)
    cards << new_cards
  end
end
