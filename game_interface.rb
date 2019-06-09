# frozen_string_literal: true

# :nodoc:
class GameInterface
  attr_reader :game

  PLAYER_ACTIONS = %i[skip_turn add_card show_cards].freeze

  def initialize(game:)
    @game = game
  end

  def run
    show_greetings

    # Game
    loop do
      puts "New round started"
      game.start_round
      run_round

      break unless continue_game?
    end
  end

  private

  def run_round
    round_results = nil
    # Round
    loop do
      show_status
      action = player_action(player_can_add_cards?)
      round_results = game.player_turn(action: action)
      break if round_results != :continue_round
    end
    show_results(round_results)
  end

  def show_greetings
    puts "Please enter your name:"
    name = gets.chomp
    puts "Hello, #{name}! Welcome to BlackJack!"
  end

  def show_status
    puts "Your account: $#{game.player_amount}"
    puts "Your cards: #{game.player_cards}, score: #{game.player_score}"
    puts "Dealer's cards: #{'*' * game.dealer_cards_count}"
  end

  def show_results(round_results)
    show_winner(round_results[:winner])
    show_status
    show_dealer_cards(round_results[:dealer])
  end

  def show_winner(winner)
    case winner
    when :player
      puts "Congratulations! You won this round"
    when :dealer
      puts "Dealer won this round"
    else
      puts "Draw! No winner"
    end
  end

  def show_dealer_cards(dealer)
    puts "Dealer's cards: #{dealer[:cards]}, score: #{dealer[:score]}"
  end

  def player_action(can_add_card = true)
    index = nil
    loop do
      index = player_action_index(can_add_card)
      valid_index = index.positive? && index <= 3 && (can_add_card || index != 2)

      break if valid_index
    end
    PLAYER_ACTIONS[index - 1]
  end

  def player_action_index(can_add_card)
    puts "Choose your action:"
    puts "1. Skip turn"
    puts "2. Add one card" if can_add_card
    puts "3. Show cards"
    gets.chomp.to_i
  end

  def continue_game?
    # TODO: check that player has enough money
    # TODO: check that dealer has enough money
    puts "Continue game?"
    puts "Press <Enter> to continue"
    puts "Input 'No' to finish game"
    result = gets.chomp.downcase
    return false if result == "no"

    true
  end

  def player_can_add_cards?
    game.player_can_add_cards?
  end
end
