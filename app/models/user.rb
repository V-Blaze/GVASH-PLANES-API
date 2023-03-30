class User < ApplicationRecord
  has_many :reservations
  require 'securerandom'
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
