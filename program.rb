# WAVE ONE TESTING...

require_relative 'account'

test = Bank::Account.new(100)

puts test.current_balance

test.deposit(50)

test.withdraw(50)

test.withdraw(96)
