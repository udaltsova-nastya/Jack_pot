# frozen_string_literal: true

class Card
  NUMBERS = %w[2 3 4 5 6 7 8 9 10].freeze
  PICTURES = %w[J Q K].freeze
  ACES = %w[A].freeze
  VALUES = NUMBERS + PICTURES + ACES
  SUITS = %w[♠ ♥ ♦ ♣].freeze

  TYPE_NUMBER = 1
  TYPE_PICTURE = 2
  TYPE_ACE = 3

  attr_reader :value, :suit, :type

  def initialize(value:, suit:)
    raise ArgumentError, "Invalid value: #{value}" unless valid_value?(value)
    raise ArgumentError, "Invalid suit: #{suit}" unless valid_suit?(suit)
    @value = value
    @suit = suit
    @type = card_type(value)
  end

  def to_s
    "#{value}#{suit}"
  end

  def inspect
    self
  end

  def number?
    type == TYPE_NUMBER    
  end

  def picture?
    type == TYPE_PICTURE
  end

  def ace?
    type == TYPE_ACE
  end

  private

  def valid_value?(value)
    VALUES.include?(value)
  end

  def valid_suit?(suit)
    SUITS.include?(suit)
  end

  def card_type(value)
    return TYPE_ACE if ACES.include?(value)
    return TYPE_PICTURE if PICTURES.include?(value)
    TYPE_NUMBER
  end
end