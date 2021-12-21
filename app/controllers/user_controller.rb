class UserController < ApplicationController
    before_action :is_admin
    
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
            total_balance += Stock.iex_api.price(stock.name)*stock.shares
        end

        @total = total_balance.round(2)
    end

    private
    def is_admin
        if authenticate_user! && current_user.admin
            redirect_to root_path
        end
    end
end
