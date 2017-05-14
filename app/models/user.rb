class User < ApplicationRecord
  has_many :applications, dependent: :destroy
  has_secure_password

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum: 8}

  before_validation do
    self.name = self.name.capitalize if self.name
  end
end
