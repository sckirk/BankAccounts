require 'csv'

module Bank
    class Account
        attr_reader :id, :balance, :open_date

        def initialize(account_hash)
            @id = account_hash[:id]
            @balance = account_hash[:balance]
            @open_date = account_hash[:open_date]

            unless @balance >= 5
                raise ArgumentError.new("All account balances must begin and maintain a minimum of $5.")
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
            unless withdrawal_amount.is_a?(Numeric)
                raise ArgumentError.new("You can only withdraw numerical values. Please log-in again.")
            end

            if @current_balance - withdrawal_amount >= 5
                @current_balance = @current_balance - withdrawal_amount
                puts "You successfully withdrew $#{ withdrawal_amount }. Your updated account balance is $#{ @current_balance }."
                return @current_balance
            else
                puts "Your current account balance is $#{ @current_balance }. You cannot withdraw $#{ withdrawal_amount } because your account must maintain a minimum of $5. Please login again to try a different withdrawal request."
                return @current_balance
            end
        end

        def deposit(deposit_amount)
            unless deposit_amount.is_a?(Numeric)
                raise ArgumentError.new("You can only deposit numerical values. Please log-in again.")
            end

            @current_balance = @current_balance + deposit_amount

            puts "You successfully deposited $#{ deposit_amount }. Your updated account balance is $#{ @current_balance }."
            return @current_balance
        end

        # def balance
        #     puts "Your current balance is $#{ @current_balance}."
        #     return @current_balance
        # end
    end
end



# WAVE TWO TESTING...
test = Bank::Account.all

puts test

puts "Woo hoo!"

test.each do |item|
    puts item.balance
end

puts "Does this work?"
works = Bank::Account.find(1216)
puts works.balance

puts "Yay!"
