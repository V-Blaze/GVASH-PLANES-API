require 'rails_helper'

RSpec.describe "Roots", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/root/index"
      expect(response).to have_http_status(:success)
    end
  end

end
