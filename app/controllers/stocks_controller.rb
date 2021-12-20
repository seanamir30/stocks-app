class StocksController < ApplicationController
#   before_action :authenticate_user!
#   before_action :find_stock, only: %i[edit update destroy]
#   include StocksHelper

  def index
    # @user_stocks = Stock.all
    @top_10_stocks = Stock.iex_api.stock_market_list(:mostactive)
    @all_stocks = Stock.iex_api.ref_data_symbols()
  end

  def search
    # SEARCH BAR
    respond_to do |format|
      begin
        if params[:symbol]
          @stock_search = Stock.iex_api.quote(params[:symbol])
          
          if @stock_search
            format.html{redirect_to stock_path(params[:symbol])}
            
          end

        end
      rescue IEX::Errors::SymbolNotFoundError => e
        format.html{redirect_to stocks_path, alert: "No symbol found"}
      end
    end
  end

  def show
    @latest_price = Stock.iex_api.price(params[:id])
    @company_name = Stock.iex_api.company(params[:id]).company_name
    @company_symbol = params[:id]
    @current_balance = current_user.balance.round(2)
    @company_market_cap = Stock.iex_api.key_stats(params[:id]).market_cap_dollar
    @action = 'buy'
    shares = Stock.find_by(user_id:current_user.id, name:params[:id])
      if shares
        @shares = shares.shares
      else
        @shares = 0
      end
    @trading_history = TradingHistory.where(user_id:current_user.id)
  end

  def payment
    if current_user
      @current_user = current_user
    end
  end

  def buy_stocks
    @stock = Stock.new
  end

  def add_stock
    stock = Stock.find_by(user_id:current_user.id, name: params[:id])
    
    respond_to do |format|
      if stock && current_user.balance >= Stock.iex_api.price(params[:id])*params[:shares].to_i
        share = stock.shares
        current_user.balance -= Stock.iex_api.price(params[:id])*params[:shares].to_i
        stock.update(shares: share += params[:shares].to_i)
        save_to_history(params[:id],Stock.iex_api.price(params[:id]), params[:shares], 'buy', current_user.id, stock.id)

      elsif current_user.balance >= Stock.iex_api.price(params[:id])*params[:shares].to_i
        current_user.balance -= Stock.iex_api.price(params[:id])*params[:shares].to_i
        new_stock = Stock.new(
          name: params[:id],
          shares: params[:shares].to_i,
          user_id: current_user.id
        )
        new_stock.save
        save_to_history(params[:id],Stock.iex_api.price(params[:id]), params[:shares], 'buy', current_user.id, stock.id)

      else
        format.html{redirect_to stock_path(params[:id]), alert: "Insufficient funds!"}
      end
      current_user.save
      format.html{redirect_to stock_path(params[:id]), notice: "Stock order fulfilled!"}
    end

  end

  def sell_stock
    respond_to do |format|
      stock = Stock.find_by(user_id:current_user.id, name: params[:id])
      if stock && stock.shares >= params[:shares].to_i
        share = stock.shares
        stock.update(shares: share -= params[:shares].to_i)
        save_to_history(params[:id],Stock.iex_api.price(params[:id]), params[:shares], 'sell', current_user.id, stock.id)
      else
        format.html{redirect_to stock_path(params[:id]),alert:"Insufficient stocks! "}

      end
      
      format.html{redirect_to stock_path(params[:id]),notice:"Stock successfully sold!"}
    end
  end

  def cash_in
    respond_to do |format|
      if params[:amount].to_i > 0
          @user = current_user
          @user.balance += params[:amount].to_i
          @user.save
          format.html{redirect_to payment_path, notice: "Transaction complete"}
      else
        format.html{redirect_to payment_path, alert: "Please enter a valid amount"}
      end
    end
  end

  def save_to_history(name, unit_price, shares, transaction_type,user_id,stock_id)
    trading_history = TradingHistory.new(
      name: name,
      unit_price: unit_price,
      shares:shares,
      user_id:user_id,
      transaction_type:transaction_type,
      stock_id:stock_id
    )
    trading_history.save 
  end

  # def search
  #   @stock_lookup = Stock.lookup(params[:symbol])
  # end
   

  private
    def stock_params
      params.require(:stock).permit(:name, :unit_price, :shares, :user_id)
    end


    
end
