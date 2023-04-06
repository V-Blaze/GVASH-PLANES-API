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

  describe 'POST /api/v1/planes' do
    before do
      @user = create(:user, id: 1) # Create a user with the ID of 1 as admin
      @user2 = create(:user) # Normal user without admin privilage
    end
    context 'when authenticated' do
      let(:headers) { { 'Authorization' => "Bearer #{token(@user)}" } } # Admin header
      let(:headers2) { { 'Authorization' => "Bearer #{token(@user2)}" } } # Normal user header

      before do
        @plane_params = {
          name: 'Boeing 747',
          plane_type: 'Commercial',
          description: 'The Boeing 747 is a large, long-range wide-body airliner.',
          image: 'https://example.com/boeing-747.jpg',
          price: 1_000_000,
          model: '747-400',
          year_of_manufacture: '20-05-2022',
          life_span: '12:30:00',
          fees: 1000.0
        }
      end

      it 'creates a new plane' do
        post '/api/v1/planes', headers:, params: @plane_params

        expect(response).to have_http_status(:success)
      end

      it 'returns an error if plane params are invalid' do
        @plane_params['name'] = nil

        post '/api/v1/planes', headers:, params: @plane_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('errors')
      end

      it 'returns an error if Normal user tries to create a plane' do
        post '/api/v1/planes', headers: headers2, params: @plane_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('error')
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized status' do
        plane_params = {
          name: 'Boeing 747',
          plane_type: 'Commercial',
          description: 'The Boeing 747 is a large, long-range wide-body airliner.',
          image: 'https://example.com/boeing-747.jpg',
          price: 1_000_000,
          model: '747-400',
          year_of_manufacture: '20-05-2022',
          life_span: '12:30:00',
          fees: 1000.0,
          user_id: @user.id
        }

        post '/api/v1/planes', params: plane_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /api/v1/planes/1' do
    let!(:user) { create(:user) }
    let!(:plane) { create(:plane) }

    context 'when authenticated' do
      before do
        headers = { 'Authorization' => "Bearer #{token(user)}" }
        get "/api/v1/planes/#{plane.id}", headers:
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not authenticated' do
      before { get '/api/v1/planes/1' }

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
