class UserController < ApplicationController
    def portfolio
        @stocks = Stock.where(user_id: current_user.id)
        @balance = current_user.balance
        total_balance = @balance

        @stocks.each do |stock|
            total_balance += Stock.iex_api.price(stock.name) 
        end

        @total = total_balance.round(2)
    end
end
