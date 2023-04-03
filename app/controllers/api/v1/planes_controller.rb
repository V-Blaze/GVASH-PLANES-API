class Api::V1::PlanesController < ApplicationController
  before_action :authenticate_request
  def index
    render json: PlaneSerializer.new(latest_planes).serializable_hash.to_json
  end

  private

  def latest_planes(offset = 0, limit = 5)
    Plane.order(updated_at: :desc).offset(offset).limit(limit)
  end
end
