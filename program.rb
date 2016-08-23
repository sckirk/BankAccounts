require_relative 'account'

test = Bank::Account.new(100)

test.balance

test.deposit(50)

test.withdraw(50)

test.withdraw(96)
