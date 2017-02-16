# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :user_name, :session_token, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 4, message: "4 ain't that hard", allow_nil: true }

  after_initialize :set_session_token

  has_many :cats
  has_many :cat_rental_requests

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def set_session_token
    self.session_token ||= generate_session_token
  end

  def reset_token!
    self.session_token = generate_session_token
  end

  def self.find_by_credentials(user_params)
    user = User.find_by_user_name(user_params[:user_name])
    return user if user && user.is_password?(user_params[:password])
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
