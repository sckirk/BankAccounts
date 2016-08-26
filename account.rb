require 'csv'

module Bank
    class Account
        MINIMUM_BALANCE = 0
        TRANSACTION_FEE = 0

        attr_reader :id, :balance, :open_date

        def initialize(account_hash)
            @id = account_hash[:id]
            @balance = account_hash[:balance]
            @open_date = account_hash[:open_date]
            @total_withdrawn = nil

            unless @balance >= self.class::MINIMUM_BALANCE
                raise ArgumentError.new("Account balances cannot be less than #{ self.class::MINIMUM_BALANCE } cents.")
            end
        end

        def self.all
            csv_accounts = []
            CSV.read('./support/accounts.csv').each do |line|
                csv_account = {}
                csv_account[:id] = line[0].to_i
                csv_account[:balance] = line[1].to_i
                csv_account[:open_date] = line[2].to_i
                csv_accounts << self.new(csv_account)
            end
            csv_accounts
        end

        def self.find(id)
            self.all.each do |object|
                if object.id == id
                    return object
                end
            end
        end

        def withdraw(withdrawal_amount)
            #COME BACK HERE, can I save this as a method and then call this method here and in the checking withdraw method?
            unless withdrawal_amount.is_a?(Numeric)
                raise ArgumentError.new("You can only withdraw numerical values. Please log-in again.")
            end

            @total_withdrawn = withdrawal_amount + self.class::TRANSACTION_FEE

            transaction_fee_incurred = "Please note: you were charged a #{ self.class::TRANSACTION_FEE } cent transaction fee on this transaction."

            if valid_withdrawal?
                @balance = @balance - @total_withdrawn
                puts "You successfully withdrew #{ withdrawal_amount } cents. Your updated account balance is #{ @balance } cents."
                if self.class::TRANSACTION_FEE != 0
                    puts transaction_fee_incurred
                end
                return @balance
            else
                puts "Your current account balance is #{ @balance } cents. You cannot withdraw #{ @total_withdrawn } cents (this includes any transaction fees, if applicable) because your account must maintain a minimum of #{ self.class::MINIMUM_BALANCE } cents. Please login again to try a different withdrawal request."
                return @balance
            end
        end

        def valid_withdrawal?
            @balance - @total_withdrawn >= self.class::MINIMUM_BALANCE
        end

        def valid_opening_amount?
            @balance < self.class::MINIMUM_BALANCE
        end

        def deposit(deposit_amount)
            unless deposit_amount.is_a?(Numeric)
                raise ArgumentError.new("You can only deposit numerical values. Please log-in again.")
            end

            @balance = @balance + deposit_amount

            puts "You successfully deposited #{ deposit_amount } cents. Your updated account balance is #{ @balance } cents."
            return @balance
        end

        # def balance
        #     puts "Your current balance is $#{ @balance}."
        #     return @balance
        # end
    end
end

# # WAVE THREE TESTING...
#
# puts "Does this work?"
# works = Bank::Account.find(1216)
# puts works.balance
#
# puts "Yay!"
#
# works.deposit(50)
#
# works.withdraw(50)
#
# works.withdraw(1000002)
#
# puts "End of Thursday's testing..."
#
#
# # WAVE TWO TESTING...
# test = Bank::Account.all
#
# puts test
#
# puts "Woo hoo!"
#
# test.each do |item|
#     puts item.balance
# end
#
# puts "Does this work?"
# works = Bank::Account.find(1216)
# puts works.balance
#
# puts "Yay!"
