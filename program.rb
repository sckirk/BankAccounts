# WAVE ONE TESTING...
## THIS NO LONGER WORKS since Wave 2 was implemented...

require_relative 'account'

test = Bank::Account.new(100)

puts test.balance

test.deposit(50)

test.withdraw(50)

test.withdraw(96)
