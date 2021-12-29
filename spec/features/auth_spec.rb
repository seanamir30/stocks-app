require 'rails_helper'


RSpec.describe 'Auth', type: :feature do

    # before(:each) do
    #     User.destroy_all
    # end

    # describe 'Unauthenticated user' do
    #     context '1. As a User, I want to create my account so that I can have my own credentials' do
           
    #         it 'renders a form to create an account' do
    #             visit new_user_registration_path
    #             expect(page).to have_content('Sign up')
    #             expect(page).to have_content('Log in')
    #             # create(:user)
    #         end
    #         it 'succesfully creates user account' do
    #             visit new_user_registration_path
    #             within 'form' do
    #                 fill_in 'Email', :with =>'amc@test.com'
    #                 fill_in 'Password', :with => '123456'
    #                 fill_in 'Password confirmation', with: '123456'
    #                 click_button 'Sign up'
    #             end
                
             
    #             expect(page).to have_content('Welcome! You have signed up successfully.')
    #             expect(page).to have_content('All Articles')
    #         end

    #         it 'does not allow invalid user input' do
    #             visit new_user_registration_path
    #             within 'form' do
    #                 fill_in 'Email', :with => nil
    #                 fill_in 'Password', :with => nil
    #                 fill_in 'Password confirmation', with: nil
    #                 click_button 'Sign up'
    #             end
    #             expect(page).to_not have_content('Welcome! You have signed up successfully.')
    #         end
    #     end
    # # end

    #     context '2. As a User, I want to login my account so that I can access my account and link my own tasks' do
            
    #         before(:each) do
    #             visit user_session_path
    #             create(:user)
    #         end

    #         it 'renders a form to login' do
    #             expect(page).to have_content('Log in')
    #             # expect(response.status).to eq(200)
    #             # expect(response).to be_successful
    #         end

    #         it 'allows authenticated access' do
    #             within 'form' do
    #                 fill_in 'Email', :with => 'amc@trial.com'
    #                 fill_in 'Password', :with => '123456'
    #                 click_button 'Log in'
    #             end
            
    #             # expect(response).to be_success
    #             expect(page).to have_content('Signed in successfully.')
    #             expect(page).to have_content('All Articles')
    #             # expect(response).to have_http_status(200)
    #             # expect(response).to be_successful
    #             # expect(respond_to).to eq('{"status":"online"}')
    #         end

    #         it "blocks unauthenticated access" do    
    #             within 'form' do
    #                 fill_in 'Email', :with => nil
    #                 fill_in 'Password', :with => nil
    #                 click_button 'Log in'
    #             end
               
    #             expect(page).to have_current_path user_session_path
    #             expect(page).to_not have_content('Signed in successfully.')
              
    #         end
    #     end
end