require 'rails_helper'

RSpec.describe 'Api::V1::PlanesReservations', type: :request do
  describe 'GET /api/v1/planes_reservations' do
    let!(:user) { create(:user) }
    let!(:planes) { create_list(:plane, 5) }

    context 'when authenticated' do
      before do
        headers = { 'Authorization' => "Bearer #{token(user)}" }
        get '/api/v1/planes_reservations', headers: headers
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not authenticated' do
      before { get '/api/v1/planes_reservations' }

      it 'returns an unauthorized response' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /api/v1/planes_reservations' do
    let(:user) { create(:user) }
    let(:plane) { create(:plane) }
    let(:valid_params) { { planes_reservation: { date: Date.today, start_time: Time.now, end_time: Time.now + 2.hours, user_id: user.id, plane_id: plane.id } } }
    let(:invalid_params) { { planes_reservation: { date: Date.today, start_time: Time.now, end_time: Time.now - 2.hours, user_id: user.id, plane_id: plane.id } } }

    context 'when authenticated' do
      before { post '/api/v1/planes_reservations', headers: { 'Authorization' => "Bearer #{token(user)}" }, params: valid_params }

      it 'creates a new plane reservation' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the created plane reservation' do
        expect(JSON.parse(response.body)['plane_reservation']['user_id']).to eq(user.id)
        expect(JSON.parse(response.body)['plane_reservation']['plane_id']).to eq(plane.id)
        expect(JSON.parse(response.body)['duration']).to eq(120)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized status' do
        post '/api/v1/planes_reservations', params: valid_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
