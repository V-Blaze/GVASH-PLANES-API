class Plane < ApplicationRecord
  has_and_belongs_to_many :reservations
  belongs_to :user

  validates :name, presence: true, length: { maximum: 100 }
  validates :plane_type, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :model, presence: true, length: { maximum: 50 }
  validates :year_of_manufacture, presence: true
  validates :life_span, presence: true
  validates :fees, presence: true, numericality: true
end
