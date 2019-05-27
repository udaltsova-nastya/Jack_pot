##
# Stores given cards
class GameTable
  def put_cards(cards:)
    @cards ||= []
    @cards << cards
  end
end
