require_relative 'account'

module Bank
    class SavingsAccount < Account
        MINIMUM_BALANCE = 1000
        TRANSACTION_FEE = 200

        def initialize(account_hash)
            super(account_hash)
        end

        def withdraw(withdrawal_amount)
            super(withdrawal_amount)
        end

        def add_interest(rate)
            interest = (rate/100) * @balance
            @balance = @balance + interest
            return interest
        end

    end
end


# WAVE THREE TESTING...

puts "Initiating a savings account with manual information:"
test = Bank::SavingsAccount.new({:id => 5268, :balance => 2000, :open_date => 1965})
print "Here's the account balance (in cents): "
puts test.balance

puts "\n\nWithdrawing 600 cents..."
puts test.withdraw(600)

puts "Successfully withdrew $6 so my account is now $12--simply confirming that this aligns with the cents below..."
puts test.balance

puts "\n\nI'd love this savings account! Adding 25% interest..."
print "Here's the interest amount: "
puts test.add_interest(0.25)
print "Here's the updated account balance: "
puts test.balance

puts "\n\nI ought to receive an error when trying to withdraw $2 more..."
puts test.withdraw(200)


puts "\n\nThursday's testing... Does this work?"
works = Bank::SavingsAccount.find(1216)
puts works.balance

puts "Yay!"

works.deposit(50)

works.withdraw(50)

works.withdraw(1000002)

puts "End of Thursday's testing...\n"
