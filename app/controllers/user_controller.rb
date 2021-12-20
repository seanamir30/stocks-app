class UserController < ApplicationController
    
    def portfolio 
           
        if params[:symbol] && params[:symbol] != ""
            @stocks = Stock.where(user_id: current_user.id, name:params[:symbol])
            if @stocks == []
                @stocks = Stock.where(user_id: current_user.id)
            end
        else 
            @stocks = Stock.where(user_id: current_user.id)
        end

        @balance = current_user.balance
        total_balance = @balance

        @stocks.each do |stock|
            total_balance += Stock.iex_api.price(stock.name) 
        end

        @total = total_balance.round(2)
    end
end
