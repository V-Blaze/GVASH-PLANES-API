class PlaneReservation < ApplicationRecord
  belongs_to :user
  belongs_to :plane

  validates :start_time, :end_time, :date, presence: true

  validate :no_conflicting_reservations
  def as_json(options = {})
    options[:methods] ||= []
    options[:methods] << :start_time_formatted
    options[:methods] << :end_time_formatted

    super(options).tap do |hash|
      hash['start_time'] = start_time.strftime('%H:%M')
      hash['end_time'] = end_time.strftime('%H:%M')
    end
  end

  def start_time_formatted
    start_time.strftime('%H:%M')
  end

  def end_time_formatted
    end_time.strftime('%H:%M')
  end

  def no_conflicting_reservations
    if PlaneReservation.where(plane_id:)
        .where('date = ? AND ((start_time < ? AND end_time > ?) OR (start_time >= ? AND start_time < ?))',
               date, end_time, start_time, start_time, end_time)
        .where.not(id:)
        .exists?
      errors.add(:base, 'This plane is already reserved at this time.')
    end
  end
end
