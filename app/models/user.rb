class User < ApplicationRecord
  has_many :applications, dependent: :destroy
  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: true
end
