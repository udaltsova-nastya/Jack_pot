# frozen_string_literal: true

##
# 1. can store money
# 2. can transfer money to another wallet (no more than stored amount)
# 3. can receive money from another wallet
class Wallet
  attr_reader :amount

  def initialize(amount = 0)
    @amount = amount
  end

  def transfer(wallet:, amount:)
    @amount -= amount
    wallet.receive(amount: amount)
  end

  def receive(amount:)
    @amount += amount
  end
end
