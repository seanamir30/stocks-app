require 'rails_helper'

RSpec.describe 'Admin', type: :request do

    let!(:admin) { User.new(
        email: "admin@email.com",
        password: "password",
        first_name: 'firstname',
        last_name: 'lastname',
        balance: 99999,
        is_approved: false,
        admin: true
    )}

    before(:each) do
        admin.skip_confirmation!
        admin.save
        sign_in admin
    end
    
    
    describe 'GET /index' do
        it 'returns the admin index page' do
        get admin_index_path
          expect(response).to be_successful
        end
    end

    describe 'GET /new' do
        it 'returns new admin path' do
            get new_admin_path
            expect(response).to be_successful
        end
    end

    describe 'POST /create' do
        it 'creates a new user with valid attributes' do
        expect do
            post admin_index_path, params: { user: {email: 'userrr@email.com',first_name:"asd", last_name: "asd", password:'password', password_confirmation:'password'}}
        end.to change(User, :count).by(1)
        end
    end

    describe 'GET /edit' do
        it 'redirects to edit page' do
            User.create!(email: 'userrr@email.com',first_name:"asd", last_name: "asd", password:'password', password_confirmation:'password')
            get edit_admin_path(User.last.id)
            expect(response).to be_successful
        end
    
        it 'updates a user' do
            User.create!(email: 'userrr@email.com',first_name:"asd", last_name: "asd", password:'password', password_confirmation:'password')
            patch admin_path(User.last.id), params: { user: {first_name:'edited@email.com'}}
            expect(User.last.first_name).to eq('edited@email.com')
        end
    end

    describe 'GET /approve_user' do
        it 'approves user' do
            User.create!(email: 'userrr@email.com',first_name:"asd", last_name: "asd", password:'password', password_confirmation:'password')
            get approve_user_path(User.last.id)
            expect(User.last.is_approved).to eq(true)
        end
    end
end

