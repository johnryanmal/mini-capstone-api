class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :carted_products

  def admin?
    admin && admin > 0
  end
end
