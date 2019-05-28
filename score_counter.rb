# frozen_string_literal: true

# счетчик
# считает 2-10 по номиналу, картинки -10, туз 1 или 11 чтобы не проиграть
# считаем очки без тузов
# в зависимости от счета 2 карт назначаем тузам 1 или 11
class ScoreCounter
  def initialize(numbers:, pictures:, aces:)
    @numbers = numbers
    @pictures = pictures
    @aces = aces
  end

  def score(cards:)
    # arr1 & arr2 - return a new array
    # containing elements common to arrays a1 and a2 (interection)
    cards_numbers = cards & numbers
    cards_pictures = cards & pictures
    cards_aces = cards & aces

    score_without_aces = score_numbers(cards_numbers) + score_pictures(cards_pictures)
    score_aces = score_aces(cards_aces, score_without_aces)

    score_without_aces + score_aces
  end

  private

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
    aces_count = cards_aces.count
    return 0 if aces_count.zero?

    # first, assume all "ace" cards score as 1
    # and see if we can convert one ace card to 11
    one_ace_can_score_11 = (11 - score_without_aces + aces_count).positive?

    if one_ace_can_score_11
      11 + (aces_count - 1)
    else
      # all ace cards still score as 1
      aces_count
    end
  end

  attr_reader :numbers, :pictures, :aces
end
