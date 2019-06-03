# frozen_string_literal: true

##
# 1. can store cards (52 by default)
# 2. shuffles cards on initialize
# 3. can give several cards (no more than remaining cards count)
# 4. can return remaining cards count
class Deck
  SUITS = ["♠", "♥", "♦", "♣"].freeze
  NUMBERS = %w[2 3 4 5 6 7 8 9 10].freeze
  PICTURES = %w[J Q K].freeze
  ACES = %w[A].freeze
  FULL_DECK = NUMBERS + PICTURES + ACES

  class << self
    def numbers
      @numbers ||= all_suits_for(NUMBERS)
    end

    def pictures
      @pictures ||= all_suits_for(PICTURES)
    end

    ##
    # @return Array[String]
    # ["A♠", "A♥", "A♦", "A♣"]
    def aces
      @aces ||= all_suits_for(ACES)
    end

    ##
    # @return Array[String]
    # ["2♠", "2♥", ..., "A♦", "A♣"]
    def full_deck
      @full_deck ||= numbers + pictures + aces
    end

    private

    def all_suits_for(card_values)
      card_values.product(SUITS).map(&:join)
    end
  end

  def initialize
    @cards = self.class.full_deck.shuffle
  end

  def take(cards_count)
    raise ArgumentError, "Недостаточно карт в колоде" if cards_count > count
    cards.pop(cards_count)
  end

  def size
    cards.size
  end
  alias count size
  alias lenght size 

  private

  attr_reader :cards
end
