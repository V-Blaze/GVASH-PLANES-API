require 'rails_helper'

RSpec.describe PlaneReservation, type: :model do
  subject do
    PlaneReservation.new({
                date: '20-05-2022',
                duration: '10',
                start_time: '11:30',
                end_time: '12:30',
                plane_id: '1'
              })
  end

  before { subject.save }

  it 'date should be present' do
    subject.date = nil
    expect(subject).to_not be_valid
  end

  it 'duration of reservation should be present' do
    subject.duration = nil
    expect(subject).to_not be_valid
  end

  it 'start_time should be present' do
    subject.start_time= nil
    expect(subject).to_not be_valid
  end

  it 'end_time must be a string and be present' do
    subject.end_time = nil
    expect(subject).to_not be_valid
  end

  it 'plane_id should be present' do
    subject.plane_id = nil
    expect(subject).to_not be_valid
  end
end
