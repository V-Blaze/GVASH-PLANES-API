class PlaneReservation < ApplicationRecord
  belongs_to :user
  belongs_to :plane

  validates :date, :user_id, :plane_id, :start_time, :end_time, presence: true

  validate :no_conflicting_reservations

  def no_conflicting_reservations
    if PlaneReservation.where(plane_id:)
        .where('start_time < ? AND end_time > ?', end_time, start_time)
        .where.not(id:)
        .exists?
      errors.add(:base, 'This plane is already reserved at this time.')
    end
  end
end
