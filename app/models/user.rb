class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true

  has_secure_password

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def User.digest string
      cost = if ActiveModel::SecurePassword.min_cost
            BCrypt::Engine::MIN_COST
           else
            BCrypt::Engine.cost
           end
      BCrypt::Password.create string, cost: cost
    end
  end
  private
    def downcase_email
      self.email.downcase!
    end
end
