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
<<<<<<< HEAD
    

  


    context '1. As a User, I want to create my account so that I can have my own credentials' do

        it 'allows authenticated access' do
            visit new_user_session_path
            fill_in('Email', :with => user.email)
            fill_in('Password', :with => user.password)
            click_on('Log in')
            
            expect(page).to have_current_path(root_path)
        end
    end
=======

   
        context '1. As a User, I want to create my account so that I can have my own credentials' do
          
            it 'renders a form to create an account' do
                visit new_user_registration_path
                expect(page).to have_content('Create an Account')
            end

            it 'succesfully creates user account' do
                visit new_user_registration_path
                within 'form' do
                    fill_in 'Email', :with =>'amc@test.com'
                    fill_in 'Password', :with => '123456'   
                    fill_in 'Password confirmation', with: '123456'
                    click_button 'Sign up'
                end
                
                expect(page).to have_current_path(root_path)
            end

            it 'does not allow invalid user input' do
                visit new_user_registration_path

                within 'form' do
                    fill_in 'Email', :with => nil
                    fill_in 'Password', :with => nil
                    fill_in 'Password confirmation', with: nil
                    click_button 'Sign up'
                end
                expect(page).to have_content('Email can\'t be blank')
                expect(page).to have_content('Password can\'t be blank')
                expect(page).to have_current_path(user_registration_path)
            end
        end
  

        context '2. As a User, I want to login my account so that I can access my account and link my own tasks' do
            
            
            it 'renders a form to login' do
                visit new_user_session_path
                expect(page).to have_content('Account Login')
            end

            it 'allows authenticated access' do
                visit new_user_session_path
                fill_in('Email', :with => user.email)
                fill_in('Password', :with => user.password)
                click_on('Log in')
    
                expect(page).to have_content(user.email)
            end

            it "blocks unauthenticated access" do    
                visit new_user_session_path
                fill_in "Email", :with => "trial@email.com"
                fill_in "Password", :with => "password"
                click_button "Log in"
                
                expect(page).to have_current_path user_session_path
            end
        end
>>>>>>> baf69dab29c4757f727be584b34a491898fb7cb2
end