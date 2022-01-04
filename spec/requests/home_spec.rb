require 'rails_helper'

RSpec.describe 'Home', type: :request do

  describe 'GET /index' do
    it 'returns the index page' do
      get root_path
      expect(response).to be_successful
    end
  end
end

