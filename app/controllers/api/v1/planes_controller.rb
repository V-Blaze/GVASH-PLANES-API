class Api::V1::PlanesController < ApplicationController

  def index
    @planes = latest_planes(plane_index_params[:offset], plane_index_params[:limit])
    render json: PlaneSerializer.new(@planes).serializable_hash.to_json
  end

  def create
    return render json: { error: "You don't have enough permission to create new plane"}, status: :unprocessable_entity unless admin?

    @plane = Plane.new(plane_params)
    @plane.user = @current_user

    if @plane.save
      render json: {plane: @plane, message: 'Plane created successfully' }, status: :created
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

  def admin?
    @current_user.id == 1
  end

  def plane_params
    params.permit(:name, :plane_type, :description, :image, :price,
                  :model, :year_of_manufacture, :life_span, :fees)
  end
end
