class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true

  def admin?
    admin && admin > 0
  end
end
