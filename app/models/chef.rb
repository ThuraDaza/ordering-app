class Chef < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 30}
  validates :password, presence: true, length: {in: 6..20}, on: :create
  validates :password, confirmation: true, on: :update
  validates :phone, presence: true, length: {in: 9..11}
  validates :address, presence: true, length: {maximum: 250}
  validates :birthday, presence: true
end
