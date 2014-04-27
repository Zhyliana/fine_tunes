# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password, :password_digest, :session_token
  before_validation :ensure_session_token
  
  validates(
    :email,
    :password,
    :password_digest,
    :session_token,
    presence: true
    )
    
  validates(
    :email,
    :session_token,
    uniqueness: true
    )
    
  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :user_id,
    primary_key: :id
    )
    
  def self.find_by_credentials(params)
    user = User.find_by_email(params[:email])
    user.is_password?(params[:password]) ? user : nil
  end
  
  def self.generate_session_token
    session_token = SecureRandom.hex
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    
    self.session_token
  end
  
  def password=(plain_text)
    if plain_text.present?
      @password = plain_text
      self.password_digest = BCrypt::Password.create(plain_text) 
    end
  end

  def is_password?(plain_text)
    BCrypt::Password.new(password_digest).is_password?(plain_text)
  end
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end
