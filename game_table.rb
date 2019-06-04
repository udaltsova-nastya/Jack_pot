# frozen_string_literal: true

##
# Stores given cards
class GameTable
  attr_reader :cards

  def initialize(score_counter:)
    @cards = []
    @score_counter = score_counter
  end

  def put(new_cards:)
    @cards += Array(new_cards)
  end

  def score
    score_counter.score(cards: cards)
  end

  private

  attr_reader :score_counter
end
