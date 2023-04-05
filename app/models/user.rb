class User < ApplicationRecord
  has_many :reservations
  require 'securerandom'
  has_secure_password
  has_many :planes
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def admin?
    id == 1
  end
end
