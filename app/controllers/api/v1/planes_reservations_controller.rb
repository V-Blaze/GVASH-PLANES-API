class Api::V1::PlanesReservationsController < ApplicationController
  def index
    reservations = PlaneReservation.where(user_id: @current_user.id).includes(:plane)
    reservations = reservations.map do |reservation|
      { reservation:, image_url: reservation.plane.image }
    end

    render json: reservations
  end

  def create
    plane_reservation = @current_user.plane_reservations.build(plane_reservation_params)

    if plane_reservation.start_time.present? && plane_reservation.end_time.present?
      duration = ((plane_reservation.end_time - plane_reservation.start_time) / 60).to_i
      plane_reservation.duration = duration

      if plane_reservation.save
        render json: { plane_reservation:, duration: }, status: :created
      else
        render json: { errors: plane_reservation.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['start_time and end_time are required'] }, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = PlaneReservation.find(params[:id])

    if @reservation.destroy
      render json: { message: 'Reservation deleted successfully' }, status: :no_content
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def plane_reservation_params
    params.require(:planes_reservation).permit(:date, :start_time, :end_time, :user_id, :plane_id)
  end
end
