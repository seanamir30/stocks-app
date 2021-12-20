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
    if params[:symbol]
      @stock_search = Stock.iex_api.quote(params[:symbol])
      
      if @stock_search
        redirect_to stock_path(params[:symbol]) 
        
      end

    end
  end

  def show
    @latest_price = Stock.iex_api.price(params[:id])
    @company_name = Stock.iex_api.company(params[:id]).company_name
    @company_symbol = params[:id]
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
  
    if stock && current_user.balance >= Stock.iex_api.price(params[:id])
      share = stock.shares
      current_user.balance -= Stock.iex_api.price(params[:id])
      stock.update(shares: share += params[:shares].to_i)
    elsif current_user.balance >= Stock.iex_api.price(params[:id])
      current_user.balance -= Stock.iex_api.price(params[:id])
      new_stock = Stock.new(
        name: params[:id],
        shares: params[:shares].to_i,
        user_id: current_user.id
      )
      new_stock.save
    end
    current_user.save


    save_to_history(params[:id],Stock.iex_api.price(params[:id]), params[:shares], 'buy', current_user.id, stock.id)

    # @stock = Stock.new(
    #   name: Stock.iex_api.company(params[:id]).company_name,
    #   unit_price: Stock.iex_api.price(params[:id]) * params[:shares].to_i,
    #   shares: params[:shares].to_i,
    #   user_id: current_user.id
    # )
    redirect_to stock_path(params[:id])

  end

  def sell_stock
    stock = Stock.find_by(user_id:current_user.id, name: params[:id])
    if stock && stock.shares >= params[:shares].to_i
      share = stock.shares
      stock.update(shares: share -= params[:shares].to_i)
      save_to_history(params[:id],Stock.iex_api.price(params[:id]), params[:shares], 'sell', current_user.id, stock.id)
    end
    
    redirect_to stock_path(params[:id])
  end

  def cash_in
    @user = current_user
    @user.balance += params[:amount].to_i
    @user.save
    redirect_to payment_path
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
