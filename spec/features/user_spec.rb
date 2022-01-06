require 'rails_helper'

RSpec.describe 'User', type: :feature do
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


    context '1. As a User, I want to see the stocks I owned' do

        it 'shows stocks that I owned' do
            visit portfolio_path

            expect(page).to have_content('AAPL Apple Inc')
            expect(page).to have_content('Net balance')
        end
    end

    context '1. As a User, I want to edit my account details' do

        it 'edits my account' do
            visit edit_user_registration_path

            expect(page).to have_content('Edit User Details')
        end
    end
end