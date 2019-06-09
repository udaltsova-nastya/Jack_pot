# frozen_string_literal: true

# Receives 2 cards from game
# Receives some amount of money from game
# Dealer's turn:
#  - skip turn (if dealer has score 17 or more)
#  - add one card (only if dealer has less then 3 cards and score is less then 17)
class Dealer
  MAX_CARDS = 3
  MAX_SCORE = 17

  def initialize(game_table:)
    @game_table = game_table
  end

  def turn
    return :skip_turn if skip_turn?

    :add_card
  end

  def score
    game_table.score
  end

  def cards
    game_table.cards
  end

  def cards_count
    game_table.count
  end

  private

  attr_reader :game_table

  def skip_turn?
    cards_count == MAX_CARDS || score >= MAX_SCORE
  end
end
