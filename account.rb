module Bank
    class Account
        attr_reader

        def initialize(initial_balance)
            @initial_balance = initial_balance
            @ID = rand(100000..999999)
            @current_balance = @initial_balance

            unless @initial_balance >= 5
                raise ArgumentError.new("All account balances must begin and maintain a minimum of $5.")
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

        def balance
            puts "Your current balance is $#{ @current_balance}."
            return @current_balance
        end
    end
end
