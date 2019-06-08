# frozen_string_literal: true

# Receives 2 cards from game
# Receives some amount of money from game
# Пропустить ход (если очков у дилера 17 или более). Ход переходит игроку.
# Добавить карту (если очков менее 17). У дилера появляется новая карта (для пользователя закрыта).
# После этого ход переходит игроку. Может быть добавлена только одна карта.
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

  private

  attr_reader :game_table

  def skip_turn?
    cards_count == MAX_CARDS || score >= MAX_SCORE
  end

  def score
    game_table.score
  end

  def cards_count
    game_table.count
  end
end
