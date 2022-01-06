require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /portfolio" do
    it "returns portfolio page" do
      get portfolio_path
      expect(response).to have_http_status(302)
    end
  end
end
