class User < ApplicationRecord
  has_secure_password
  has_many :links

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
end
