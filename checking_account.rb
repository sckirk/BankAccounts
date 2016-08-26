require_relative 'account'

module Bank
    class CheckingAccount < Account
        # MINIMUM_BALANCE = 1000
        TRANSACTION_FEE = 100

        attr_reader :check_number

        def initialize(account_hash)
            super(account_hash)
            @check_account_overdraw_maximum = -1000
            @check_number = 0
            @free_checks = 3
            @check_transaction_fee = 0
        end

        def withdraw(withdrawal_amount)
            super(withdrawal_amount)
        end

        def withdraw_using_check(amount)
            unless amount.is_a?(Numeric)
                raise ArgumentError.new("You can only withdraw numerical values. Please log-in again.")
            end

            @total_withdrawn = amount + @check_transaction_fee

            if @check_number < @free_checks
                if valid_check_withdrawal?
                    @balance = @balance - @total_withdrawn
                    @check_number += 1
                    puts "You successfully withdrew #{ amount } cents. Your updated account balance is #{ @balance } cents."
                    return @balance
                else
                    puts "Your current account balance is #{ @balance } cents. You cannot withdraw #{ @total_withdrawn } cents because your account cannot exceed your #{ @check_account_overdraw_maximum.abs } cent overdraft limit. Please login again to try a different withdrawal request."
                    return @balance
                end
            else
                @check_transaction_fee = 200
                if valid_check_withdrawal?
                    @balance = @balance - @total_withdrawn
                    @check_number += 1
                    puts "You successfully withdrew #{ amount } cents. NOTE: You are allowed #{ @free_checks } free check withdrawals per month. You incurred a #{ @check_transaction_fee } cent check transaction fee today because you have written #{ @check_number } checks this month. Your updated account balance is #{ @balance } cents."
                    return @balance
                else
                    puts "Your current account balance is #{ @balance } cents. You cannot withdraw #{ @total_withdrawn } cents (includes your check transaction fee) because your account cannot exceed your #{ @check_account_overdraw_maximum.abs } cent overdraft limit. Please login again to try a different withdrawal request."
                    return @balance
                end
            end
        end

        def valid_check_withdrawal?
            @balance - @total_withdrawn >= @check_account_overdraw_maximum
        end

        def reset_checks
            @check_number = 0
        end
    end
end


# WAVE THREE TESTING...

puts "Initiating a checking account with manual information:"
test = Bank::CheckingAccount.new({:id => 5268, :balance => 2000, :open_date => 1965})
print "Here's the account balance (in cents): "
puts test.balance

puts "\n\nWithdrawing 600 cents..."
puts test.withdraw(600)

puts "Successfully withdrew $6 so my account is now $13--simply confirming that this aligns with the cents below..."
puts test.balance

puts "\n\nI ought to receive an error when trying to withdraw $14 more..."
puts test.withdraw(1400)

# NOW TESTING MY CHECK WITHDRAWAL METHOD...

puts "\n\n\nHere's my 'first' check..."
puts test.withdraw_using_check(100)
print "Here's the check number: "
puts test.check_number

puts "\nHere's my 'second' check..."
puts test.withdraw_using_check(100)
print "Here's the check number: "
puts test.check_number

puts "\nHere's my 'third' check..."
puts test.withdraw_using_check(100)
print "Here's the check number: "
puts test.check_number

puts "\nHere's my 'fourth' check, incurring a fee?"
puts test.withdraw_using_check(50)
print "Here's the check number: "
puts test.check_number

puts "\nThis ought to error..."
puts test.withdraw_using_check(1960)
