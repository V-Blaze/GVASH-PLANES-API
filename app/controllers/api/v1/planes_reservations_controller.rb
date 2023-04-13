class Api::V1::PlanesReservationsController < ApplicationController
  def index
    reservations = PlaneReservation.where(user_id: @current_user.id).includes(:plane)
    reservations = reservations.map do |reservation|
      { reservation:, image_url: reservation.plane.image, name: reservation.plane.name }
    end

    render json: reservations
  end

  def create
    plane_reservation = @current_user.plane_reservations.build(plane_reservation_params)

    if plane_reservation.start_time.present? && plane_reservation.end_time.present?
      duration_in_minutes = ((plane_reservation.end_time - plane_reservation.start_time) / 60).to_i
      plane_reservation.duration = duration_in_minutes

      if plane_reservation.save
        duration_in_hours = duration_in_minutes / 60
        duration_in_minutes %= 60
        duration_formatted = format('%<duration_in_hours>d:%<duration_in_minutes>02d',
                                    duration_in_hours:, duration_in_minutes:)

        render json: { plane_reservation:, duration: duration_formatted }, status: :created
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
