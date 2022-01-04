require 'rails_helper'

RSpec.describe 'Admin', type: :request do

    # before(:each) do
    #     User.destroy_all
    #     sign_in create(:user, admin:true)
    # end
    
    # describe 'GET /index' do
    #     it 'returns the admin index page' do
    #     get admin_index_path
    #     #   expect(response).to be_successful
    #     expect(response.status).to eq(200)
    #     end
    # end

    # describe 'GET /new' do
    #     get new_admin_path
    #     expect(response).to be_successful
    # end

    # describe 'POST /create' do
    #     it 'creates a new user with valid attributes' do
    #     expect do
    #         post admin_index_path, params: { user: {email: 'userrr@email.com', password:'password', password_confirmation:'password'}}
    #     end.to change(User, :count).by(1)
    #     end
    # end

    # describe 'GET /edit' do
    #     it 'redirects to edit page' do
    #         User.create!(email: 'userrr@email.com', password:'password', password_confirmation:'password')
    #         get edit_admin_path(User.last.id)
    #         expect(response).to be_successful
    #     end
    
    #     it 'updates a user' do
    #       patch admin_path(User.last.id), params: { user: {email:'edited@email.com'}}
    #       expect(User.last.email).to eq('edited@email.com')
    #     end
    #   end
end

