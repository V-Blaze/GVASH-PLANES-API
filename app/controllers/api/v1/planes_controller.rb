class Api::V1::PlanesController < ApplicationController
  def index
    @planes = latest_planes(plane_index_params[:offset], plane_index_params[:limit])
    render json: PlaneSerializer.new(@planes).serializable_hash.to_json
  end

  private

  def latest_planes(offset = 0, limit = nil)
    Plane.order(updated_at: :desc).offset(offset).limit(limit)
  end

  def plane_index_params
    params.permit(:offset, :limit)
  end
end
