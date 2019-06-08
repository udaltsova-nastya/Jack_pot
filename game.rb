# frozen_string_literal: true

require_relative "deck"
require_relative "score_counter"
require_relative "player"
require_relative "dealer"
require_relative "croupier"
require_relative "game_bank"
require_relative "game_table"

##
# gives 2 cards to player and dealer
# gives 100$ to player and dealer
# takes 10$ from player and dealer at the beginning of each round
# transfers 20$ to the winner at the end of of each round
# returnes back 10$ to player and dealer in case of draw
class Game
  START_AMOUNT = 100
  BET_AMOUNT = 10

  DECK_NUMBERS = Deck.numbers
  DECK_PICTURES = Deck.pictures
  DECK_ACES = Deck.aces

  AVAILABLE_ACTIONS = %i[skip_turn add_card show_cards].freeze

  def initialize
    start_game
  end

  def round_start
    @deck = create_deck
    place_a_bet

    deal_card_to_player(2)
    deal_card_to_dealer(2)
  end

  def player_turn(action:)
    raise ArgumentError, "Неверное действие" unless AVAILABLE_ACTIONS.include?(action)

    continue_round = send("player_#{action}")

    continue_round = false ЕСЛИ У ВСЕХ УЖЕ ПО ТРИ КАРТЫ

    return if continue_round

    round_finish
  end

  private

  attr_reader :player, :dealer, :player_game_table, :dealer_game_table, :deck

  def start_game
    @player_game_table = create_game_table
    @player = create_player(player_game_table)

    @dealer_game_table = create_game_table
    @dealer = create_dealer(dealer_game_table)

    create_account(:game)
    create_account(:dealer, START_AMOUNT)
    create_account(:player, START_AMOUNT)
  end

  def round_finish
    winner = select_winner
    payout(winner)
    winner
  end

  def place_a_bet
    transfer(:dealer, :game, BET_AMOUNT)
    transfer(:player, :game, BET_AMOUNT)
  end

  def deal_card_to_player(cards_count = 1)
    deal_cards(cards_count, player_game_table)
  end

  def deal_card_to_dealer(cards_count = 1)
    deal_cards(cards_count, dealer_game_table)
  end

  def deal_cards(cards_count, game_table)
    croupier.deal_cards(cards_count: cards_count, deck: deck, game_table: game_table)
  end

  def create_account(name, amount = 0)
    game_bank.create_account(name: name, amount: amount)
  end

  def transfer(from, to, amount)
    game_bank.transfer(from: from, to: to, amount: amount)
  end

  def player_skip_turn
    dealer_turn
  end

  def player_add_card
    deal_card_to_player
    true
  end

  def player_show_cards
    false
  end

  def dealer_turn
    send("dealer_#{dealer.turn}")
  end

  def dealer_skip_turn
    true
  end

  def dealer_add_card
    deal_card_to_dealer
    true
  end

  def create_player(game_table)
    Player.new(game_table: game_table)
  end

  def create_dealer(game_table)
    Dealer.new(game_table: game_table)
  end

  def create_game_table
    GameTable.new(score_counter: score_counter)
  end

  # New deck for each round
  def create_deck
    Deck.new
  end

  def game_bank
    @game_bank ||= GameBank.new
  end

  def croupier
    @croupier ||= Croupier.new
  end

  def score_counter
    @score_counter ||= ScoreCounter.new(numbers: DECK_NUMBERS, pictures: DECK_PICTURES, aces: DECK_ACES)
  end
end
