require 'rails_helper'

RSpec.describe 'Api::V1::Planes', type: :request do
  describe 'GET /api/v1/planes' do
    let!(:user) { create(:user) }
    let!(:planes) { create_list(:plane, 5) }

    context 'when authenticated' do
      before do
        headers = { 'Authorization' => "Bearer #{token(user)}" }
        get '/api/v1/planes', headers:
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns the latest planes' do
        json_response = JSON.parse(response.body)

        expect(json_response['data'].count).to eq(5)
        expect(json_response['data'][0]['id']).to eq(planes.last.id.to_s)
      end
    end

    context 'when not authenticated' do
      before { get '/api/v1/planes' }

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
