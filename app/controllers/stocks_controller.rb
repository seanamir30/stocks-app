class StocksController < ApplicationController
#   before_action :authenticate_user!
#   before_action :find_stock, only: %i[edit update destroy]
#   include StocksHelper

  def index
    # @user_stocks = Stock.all
    @stocks = Stock.iex_api.ref_data_symbols()
    @all_stocks = Kaminari.paginate_array(@stocks).page(params[:page]).per(10)
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
    chart = Stock.iex_api.chart(params[:id])
    index = 0
    ohlc = []
    chart.each do |data|
      candle = [data.date,data.close]

      ohlc.push(candle)
    end

    @chart_data = ohlc


    if current_user && current_user.is_approved && user_signed_in?
      @trading_history = TradingHistory.where(user_id:current_user.id)
      shares = Stock.find_by(user_id:current_user.id, name:params[:id])
      @current_balance = current_user.balance.round(2)
    end
    @latest_price = Stock.iex_api.price(params[:id])
    @company_name = Stock.iex_api.company(params[:id]).company_name
    @company_symbol = params[:id]
    
    @company_market_cap = Stock.iex_api.key_stats(params[:id]).market_cap_dollar
    @action = 'buy'
    
      if shares
        @shares = shares.shares
      else
        @shares = 0
      end
    
  end

  def payment
    respond_to do |format|
      if !user_signed_in?
        format.html{redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing."}
      elsif current_user.admin || !current_user.is_approved
        format.html{redirect_to root_path}
      end
        format.html{}
    end
  end

  def buy_stocks
    @stock = Stock.new
  end

  def add_stock
    stock = Stock.find_by(user_id:current_user.id, name: params[:id])
    price = Stock.iex_api.price(params[:id])
    
    
    respond_to do |format|
      if stock && current_user.balance >= price*params[:buy_shares].to_i
        share = stock.shares
        current_user.balance -= price*params[:buy_shares].to_i
        stock.update(shares: share += params[:buy_shares].to_i)
        save_to_history(params[:id],price, params[:buy_shares], 'buy', current_user.id, stock.id)

      elsif current_user.balance >= price*params[:buy_shares].to_i
        current_user.balance -= price*params[:buy_shares].to_i
        new_stock = Stock.new(
          name: params[:id],
          shares: params[:buy_shares].to_i,
          user_id: current_user.id
        )
        new_stock.save
        save_to_history(params[:id],price, params[:buy_shares], 'buy', current_user.id, new_stock.id)

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
      if stock && stock.shares >= params[:sell_shares].to_i
        current_user.balance += Stock.iex_api.price(params[:id]) * params[:sell_shares].to_i
        current_user.save
        share = stock.shares
        stock.update(shares: share -= params[:sell_shares].to_i)
        save_to_history(params[:id],Stock.iex_api.price(params[:id]), params[:sell_shares], 'sell', current_user.id, stock.id)
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
