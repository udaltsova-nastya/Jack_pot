# frozen_string_literal: true

##
# Counts score for given cards:
# numbers (2-10) by its values;
# all pictures scores equal 10;
# aces score equals 1 or 11 depending on what is closer to 21, but not exceeds 21
# first, count score without aces
# then assume, that each ace equals 1
# finally, check if one ace can be scored as 11
class ScoreCounter
  def score(cards:)
    numbers = select_numbers(cards)
    pictures = select_pictures(cards)
    aces = select_aces(cards)

    score_without_aces = score_numbers(numbers) + score_pictures(pictures)
    score_aces = score_aces(aces, score_without_aces)

    score_without_aces + score_aces
  end

  private

  def select_numbers(cards)
    cards.select(&:number?)
  end

  def select_pictures(cards)
    cards.select(&:picture?)
  end

  def select_aces(cards)
    cards.select(&:ace?)
  end

  # each "number" card scores as its value
  def score_numbers(cards_numbers)
    cards_numbers.sum { |card| card.value.to_i }
  end

  # each "picture" card scores as 10
  def score_pictures(cards_pictures)
    cards_pictures.count * 10
  end

  # each "ace" card can score 11 or 1,
  # depending on what is closer to 21,
  # but not exceeding 21
  def score_aces(cards_aces, score_without_aces)
    # first, assume all "ace" cards score as 1
    aces_count = cards_aces.count
    return 0 if aces_count.zero?

    # check if we can convert one ace card to 11
    if (score_without_aces + aces_count <= 11)
      11 + (aces_count - 1)
    else
      # all ace cards still score as 1
      aces_count
    end
  end
end
