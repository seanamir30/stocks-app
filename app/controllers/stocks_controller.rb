class StocksController < ApplicationController
#   before_action :authenticate_user!
#   before_action :find_stock, only: %i[edit update destroy]
#   include StocksHelper

  
  def index
    # @user_stocks = Stock.all

    @top_10_stocks = Stock.iex_api.stock_market_list(:mostactive)

    @all_stocks = Stock.iex_api.ref_data_symbols()
  end

  def show
    @latest_price = Stock.iex_api.price(params[:id])
    @company_name = Stock.iex_api.company(params[:id]).company_name
    @company_symbol = params[:id]
    @company_market_cap = Stock.iex_api.key_stats(params[:id]).market_cap_dollar
  end

  def payment
    if current_user
      @current_user = current_user
    end
  end

  def buy_stocks
    @user = current_user
    @user.balance -= Stock.iex_api.price(params[:id])
    @user.save
    @stock = Stock.new
  end

  def add_stock
    stock = Stock.where(user_id:current_user.id, name: params[:id])
    if stock.any?
      share = stock.first.shares
      stock.update(shares: share += params[:shares].to_i)
    else
      new_stock = Stock.new(
        name: params[:id],
        shares: params[:shares].to_i,
        user_id: current_user.id
      )

      new_stock.save
    end
    # @stock = Stock.new(
    #   name: Stock.iex_api.company(params[:id]).company_name,
    #   unit_price: Stock.iex_api.price(params[:id]) * params[:shares].to_i,
    #   shares: params[:shares].to_i,
    #   user_id: current_user.id
    # )
    redirect_to stock_path(params[:id])
  end

  def cash_in
    @user = current_user
    @user.balance += params[:amount].to_i
    @user.save
    redirect_to payment_path
  end

  private
  def stock_params
    params.require(:stock).permit(:name, :unit_price, :shares, :user_id)
  end


end
