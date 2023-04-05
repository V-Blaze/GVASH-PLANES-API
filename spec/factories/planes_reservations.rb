FactoryBot.define do
  factory :plane_reservation do
    date { '2023-10-02' }
    duration { '20' }
    start_time { '11:00'}
    end_time { '11:30' }
  end
end
