# frozen_string_literal: true

##
# Deals given cards count from the deck to the game table
class Croupier
  def deal_cards(cards_count:, deck:, game_table:)
    cards = deck.take(cards_count)
    game_table.put(new_cards: cards)
  end
end
