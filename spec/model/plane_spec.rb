require 'rails_helper'

RSpec.describe Plane, type: :model do
  subject do
    Plane.new({
                name: 'Boeing 747',
                plane_type: 'Commercial',
                description: 'The Boeing 747 is a large, long-range wide-body airliner.',
                image: 'https://example.com/boeing-747.jpg',
                price: 1_000_000,
                model: '747-400',
                year_of_manufacture: '20-05-2022',
                life_span: '12:30:00',
                fees: 1000.0
              })
  end

  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'plane_type should be present' do
    subject.plane_type = nil
    expect(subject).to_not be_valid
  end

  it 'description should be present' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'image must be a string and be present' do
    subject.image = nil
    expect(subject).to_not be_valid
  end

  it 'price should be present' do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it 'model should be present' do
    subject.model = nil
    expect(subject).to_not be_valid
  end
end
