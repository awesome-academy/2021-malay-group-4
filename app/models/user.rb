class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email

  has_secure_password

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true

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

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
    def downcase_email
      self.email.downcase!
    end
end
