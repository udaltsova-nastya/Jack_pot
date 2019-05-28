# frozen_string_literal: true

##
# Deals given cards count from the deck to the game_table
class Croupier
  def deal_cards(cards_count:, deck:, game_table:)
    cards = deck.take(cards_count)
    game_table.put_cards(cards: cards)
  end
end
