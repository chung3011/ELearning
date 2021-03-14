class User < ApplicationRecord
  acts_as_paranoid
  before_create :create_activation_digest
  before_save :downcase_mail
  has_secure_password
  attr_accessor :remember_token, :activation_token, :reset_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :mail,
    presence: true,
    length: {maximum: 50},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  
  has_many :follow_tags, dependent: :destroy
  has_many :course_comments, dependent: :destroy
  has_many :course_rates, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :user_lessons, dependent: :destroy
  has_many :user_exams, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :lessons, through: :user_lessons
  has_many :tags, through: :follow_tags

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.hex
    end

    def from_omniauth auth
      user_check = User.only_deleted.find_by mail: auth.info.email
      return if user_check.present?
      where(mail: auth.info.email).first_or_initialize do |user|
        user.name = auth.info.name
        user.mail = auth.info.email
        user.password = User.new_token
        user.activated = true
        user.save!
      end
    end
  end

  def downcase_mail
    mail.downcase!
  end
  
  def valid_token? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attributes reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hour.ago
  end
end
