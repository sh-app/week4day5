# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime
#  updated_at      :datetime
#

require 'securerandom'

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  validates :password_digest, presence: true

  has_many(
    :subs,
    class_name: 'Sub',
    foreign_key: :moderator_id
  )

  has_many(
    :posts,
    class_name: 'Post',
    foreign_key: :author_id
  )

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    return user if user.is_password?(password)
    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= self.get_session_token
  end

  def get_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.get_session_token
    self.save!
    session_token
  end

end
