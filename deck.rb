# frozen_string_literal: true

require_relative "card"

##
# 1. can store cards (52 by default)
# 2. shuffles cards on initialize
# 3. can give several cards (no more than remaining cards count)
# 4. can return remaining cards count
class Deck
  class << self
    def all_cards
      @all_cards ||= create_cards
    end

    private

    def create_cards
      cards_values.product(cards_suits).map do |(value, suit)|
        create_card(value, suit)
      end
    end

    def create_card(value, suit)
      Card.new(value: value, suit: suit)
    end

    def cards_values
      Card::VALUES
    end

    def cards_suits
      Card::SUITS
    end
  end

  def initialize
    @cards = self.class.all_cards.shuffle
  end

  def take(cards_count)
    raise ArgumentError, "Недостаточно карт в колоде" if cards_count > count

    cards.pop(cards_count)
  end

  def size
    cards.size
  end
  alias count size
  alias length size

  def inspect
    string = "#<#{self.class.name}:#{self.object_id} #{size} card(s)>"
  end

  private

  attr_reader :cards
end
