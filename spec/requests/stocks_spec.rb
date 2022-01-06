require 'rails_helper'

RSpec.describe "Stocks", type: :request do

  let!(:user) { User.new(
    email: "try@email.com",
    password: "password",
    first_name: 'firstname',
    last_name: 'lastname',
    balance: 99999,
    is_approved: false,
    admin: false
  )}

  before(:each) do
      user.skip_confirmation!
      user.save
      sign_in user
  end

  describe "GET /stocks" do
    it "returns stocks index page" do
      get stocks_path
      expect(response).to be_successful
    end
  end

  describe "GET /stock/:id" do
    it "shows stock details" do
      get stock_path('AAPL')
      expect(response).to be_successful
    end

    it "POST /buy_stock" do
      post add_stock_path, params:{id:'AAPL', buy_shares: 1}
      expect(response).to have_http_status(302)
    end
    it "POST /sell_stock" do
      post add_stock_path, params:{id:'AAPL', sell_shares: 1}
      expect(response).to have_http_status(302)
    end
  end

  describe "POST /search" do
    it "searches" do
      post search_path, params:{symbol:'AAPL'}
      expect(response).to have_http_status(302)
    end
  end
    
end
