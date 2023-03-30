class Plane < ApplicationRecord
    has_and_belongs_to_many :reservations
end
