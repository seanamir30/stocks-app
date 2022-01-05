require 'rails_helper'

RSpec.describe 'Stock', type: :feature do
    
    
    let!(:user) { User.new(
        email: "try@email.com",
        password: "password",
        first_name: 'firstname',
        last_name: 'lastname',
        balance: 99999,
        is_approved: true 
    )}

    before(:each) do
        user.skip_confirmation!
        user.save
        login(user)

        visit stock_path("AAPL")   
        fill_in "buy_shares", :with => 2
        click_button("buy")
        
    end
    
    context '1. As a User, I want to buy stocks from the market' do

        it 'buys stocks' do
           
            visit stock_path("AAPL")  
            expect(page).to have_content('Apple')
            
            fill_in "buy_shares", :with => 2
            click_button("buy")
            
            expect(page).to have_content("Current shares owned: 4")
        end

        it 'sells stocks' do
           
            visit stock_path("AAPL")  
            expect(page).to have_content('Apple')
            
            fill_in "sell_shares", :with => 1
            click_button("sell")
            
            expect(page).to have_content("Current shares owned: 1")
        end

        it 'logs the stock that the user bought' do
            visit stock_path("AAPL")  
            expect(page).to have_content('Apple')
            
            fill_in "buy_shares", :with => 2
            click_button("buy")
            
            expect(page).to have_content('AAPL buy 2')
        end

        it 'logs the stock that the user sold' do
            visit stock_path("AAPL")  
            expect(page).to have_content('Apple')
            
            fill_in "sell_shares", :with => 1
            click_button("sell")
            
            expect(page).to have_content('AAPL sell 1')
        end
    end
end