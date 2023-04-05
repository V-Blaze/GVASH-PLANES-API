class Api::V1::ReservationsController < ApplicationController
  
  def index
    reservations = @current_user.reservations
    render json: reservations
  end

  def create
    plane = Plane.find(params[:reservation][:plane_id])
    date = Date.parse(params[:reservation][:date])
    start_time = DateTime.new(date.year, date.month, date.day, Time.zone.now.hour, Time.zone.now.min, Time.zone.now.sec, Time.zone.now.zone)
    end_time = start_time + params[:reservation][:duration].to_i.minutes
    puts "duration parameter received from client: #{params[:reservation][:duration]}"

    reservation = @current_user.reservations.build(plane: plane, start_time: start_time, end_time: end_time, date: date, duration: params[:reservation][:duration])
    
    if reservation.save
      render json: reservation, status: :created
    else
      render json: { error: reservation.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    reservation = @current_user.reservations.find(params[:id])
    reservation.destroy
    head :no_content
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :duration, :plane_id)
  end
  
end
