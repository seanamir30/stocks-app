require 'rails_helper'

RSpec.describe 'Auth', type: :feature do

    let!(:user) { User.new(
        email: "try@email.com",
        password: "password",
        first_name: 'firstname',
        last_name: 'lastname'
    ) }


    before do
        user.skip_confirmation!
        user.save
    end
    

  


    context '1. As a User, I want to create my account so that I can have my own credentials' do

        it 'allows authenticated access' do
            visit new_user_session_path
            fill_in('Email', :with => user.email)
            fill_in('Password', :with => user.password)
            click_on('Log in')
            
            expect(page).to have_current_path(root_path)
        end
    end
end