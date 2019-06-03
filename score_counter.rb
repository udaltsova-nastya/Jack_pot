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
  def initialize(numbers:, pictures:, aces:)
    @numbers = numbers
    @pictures = pictures
    @aces = aces
  end
  
  def score(cards:)
    # arr1 & arr2 - return a new array
    # containing elements common to arrays a1 and a2 (intersection)
    cards_numbers = cards & numbers
    cards_pictures = cards & pictures
    cards_aces = cards & aces

    score_without_aces = score_numbers(cards_numbers) + score_pictures(cards_pictures)
    score_aces = score_aces(cards_aces, score_without_aces)

    score_without_aces + score_aces
  end

  private

  attr_reader :numbers, :pictures, :aces

  # each "number" card scores as its value
  def score_numbers(cards_numbers)
    cards_numbers.sum(&:to_i)
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

    # then check if we can convert one ace card to 11
    one_ace_can_score_11 = (11 - score_without_aces + aces_count).positive?

    if one_ace_can_score_11
      11 + (aces_count - 1)
    else
      # all ace cards still score as 1
      aces_count
    end
  end
end
