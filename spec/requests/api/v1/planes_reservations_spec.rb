require 'rails_helper'

RSpec.describe 'Api::V1::PlanesReservations', type: :request do
  describe 'GET /api/v1/planes_reservations' do
    let!(:user) { create(:user) }
    let!(:planes) { create_list(:plane, 5) }

    context 'when authenticated' do
      before do
        headers = { 'Authorization' => "Bearer #{token(user)}" }
        get '/api/v1/planes_reservations', headers:
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
    let(:valid_params) do
      { planes_reservation: { date: Date.today, start_time: Time.now, end_time: Time.now + 2.hours, user_id: user.id,
                              plane_id: plane.id } }
    end
    let(:invalid_params) do
      { planes_reservation: { date: Date.today, start_time: Time.now, end_time: Time.now - 2.hours, user_id: user.id,
                              plane_id: plane.id } }
    end

    context 'when authenticated' do
      before do
        post '/api/v1/planes_reservations', headers: { 'Authorization' => "Bearer #{token(user)}" },
                                            params: valid_params
      end

      it 'creates a new plane reservation' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the created plane reservation' do
        expect(JSON.parse(response.body)['plane_reservation']['user_id']).to eq(user.id)
        expect(JSON.parse(response.body)['plane_reservation']['plane_id']).to eq(plane.id)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized status' do
        post '/api/v1/planes_reservations', params: valid_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/planes_reservations' do
    before do
      @user = create(:user) # Create a user with the ID of 1 as admin
      @plane = create(:plane)
      @reservation = PlaneReservation.create({ date: Date.today,
                                               start_time: Time.now,
                                               end_time: Time.now + 2.hours, user_id: @user.id,
                                               plane_id: @plane.id })
    end

    context 'when authenticated' do
      let(:headers) { { 'Authorization' => "Bearer #{token(@user)}" } }

      it 'deletes a reservation' do
        delete("/api/v1/planes_reservations/#{@reservation.id}", headers:)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when not authenticated' do
      it 'deletes a plan' do
        delete '/api/v1/planes_reservations/1'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
