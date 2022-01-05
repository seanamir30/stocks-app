require 'rails_helper'

RSpec.describe 'Admin', type: :feature do
    
    let!(:admin) { User.new(
        email: "admin@email.com",
        password: "password",
        first_name: 'firstname',
        last_name: 'lastname',
        balance: 99999,
        is_approved: false,
        admin: true
    )}

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
        admin.skip_confirmation!
        admin.save
        user.skip_confirmation!
        user.save
        login(admin)
    end


    context '1. As an Admin, I want to create a new user' do

        it 'creates a new user' do
            
            visit new_admin_path

            expect(page).to have_content('Create an Account')
            fill_in 'Email', :with =>'sc@test.com'
            fill_in 'First name', :with =>'sc@test.com'
            fill_in 'Last name', :with =>'sc@test.com'
            fill_in 'Password', :with =>'sc@test.com'
            fill_in 'Password confirmation', :with => '123456'   
    
            click_button 'Create Account'

            visit admin_index_path
            expect(page).to have_content('sc@test.com')
        end
    end

    context '2. As an Admin, I want to edit user details' do

        it 'edits user details' do
            visit admin_index_path
            click_on 'edit'

            expect(page).to have_content('Edit User Details')
            fill_in 'Email', :with =>'scedited@test.com'
            fill_in 'First name', :with =>'scc'
            fill_in 'Last name', :with =>'scclast'

            click_button 'Update'
            
            expect(page).to have_content('scc scclast')

        end
    end

    context '3. As an Admin, I want to view a specific user to show his/her details' do

        it 'shows user details' do
            visit admin_index_path
            click_on 'details'
            
        
            expect(page).to have_content('firstname lastname')

        end
    end

    context '4. As an Admin, I want to see all the users that registered in the app so I can track all the users and approve them ' do

        it 'shows user details' do
            visit admin_index_path
            expect(page).to have_content('Users with pending approval')
            expect(page).to have_content('Approved Accounts')
            expect(page).to have_content('firstname lastname')
        end
    end

end