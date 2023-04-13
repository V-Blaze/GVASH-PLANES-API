class Api::V1::PlanesController < ApplicationController
  before_action :check_admin, only: %i[create destroy]
  skip_before_action :authenticate_request, only: [:index, :show]
  def index
    @planes = latest_planes(plane_index_params[:offset], plane_index_params[:limit])
    render json: PlaneSerializer.new(@planes).serializable_hash.to_json
  end

  def show
    @plane = Plane.find(params[:id])
    render json: PlaneSerializer.new(@plane).serializable_hash.to_json
  end

  def create
    @plane = Plane.new(plane_params)
    @plane.user = @current_user

    if @plane.save
      render json: { planeID: @plane.id, message: 'Plane created successfully' }, status: :created
    else
      render json: { errors: @plane.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @plane = Plane.find(params[:id])

    if @plane.destroy
      render json: { message: 'Plane deleted successfully' }, status: :no_content
    else
      render json: { errors: @plane.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def latest_planes(offset = 0, limit = nil)
    Plane.order(updated_at: :desc).offset(offset).limit(limit)
  end

  def plane_index_params
    params.permit(:offset, :limit)
  end

  def plane_params
    params.permit(:name, :plane_type, :description, :image, :price,
                  :model, :year_of_manufacture, :life_span, :fees)
  end
end
