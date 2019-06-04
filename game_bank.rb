# frozen_string_literal: true

##
# Creates accouns for given account name and amount
#   if account already exists we raise an error
# transfers given amount from one account to another
#  if either account is missing - raises an error
#  if sender don't have sufficient amount - raises an error
class GameBank
  def initialize
    @accounts = {}
  end

  def create_account(name:, amount: 0)
    raise ArgumentError, "Счет с таким названием уже существует" if account_exists?(name)

    accounts[name] = amount
  end

  def transfer(from:, to:, amount:)
    raise ArgumentError, "Счет отправителя не существует" unless account_exists?(from)
    raise ArgumentError, "Счет получателя не существует" unless account_exists?(to)
    raise ArgumentError, "Недостаточно средств на счете отправителя" if amount > account_amount(from)

    accounts[from] -= amount
    accounts[to] += amount
  end

  private

  def account_exists?(name)
    accounts.key?(name)
  end

  def account_amount(name)
    accounts[name]
  end

  attr_reader :accounts
end
