##
# 1. can store cards (52 by default)
# 2. shuffles cards on initialize
# 3. can give several cards (no more than remaining cards count)
# 4. can return remaining cards count
class Deck
  def initialize
    @cards = initialize_cards.shuffle
  end

  def take(cards_count)
    raise ArgumentError, "Недостаточно карт в колоде" if cards_count > count
    @cards.pop(cards_count)
  end

  def size
    @cards.size
  end
  alias count size
  alias length size

  private 

  ##
  # @return Array[String]
  # ["2♠", "2♥", ..., "A♦", "A♣"]
  def initialize_cards
    suits = ["♠", "♥", "♦", "♣"]
    values = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    values.product(suits).map(&:join)
    # cards = []
    # suits.each do |suit|
    #   values.each do |value|
    #     card = value + suit
    #     cards << card
    #   end
    # end
    # cards
  end
end
