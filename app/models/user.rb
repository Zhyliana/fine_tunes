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
  
  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :user_id,
    primary_key: :id
    )
  
  validates(
    :email,
    :password,
    :session_token,
    presence: true
    )
    
  validates(
    :email,
    :session_token,
    uniqueness: true
    )
  
  
  def self.generate_session_token
    session_token = SecureRandom.hex
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.hex
    self.session_token.save
    session_token
  end
  
  def password=(secret)
    if secret.present?
      @password = secret
      self.password_digest = BCrypt::Password.create(secret) 
    end
  end

  def is_password?(secret)
    BCrypt::Password.new(password_digest).is_password?(secret)
  end
  
  def self.find_by_credentials(email, secret)
    @user = User.find_by_email(email)
    
    if @user.try(:is_password?, secret)
      return @user
    else
      puts "Why you tryna hack?"
    end
  end
  
  def ensure_session_token
    #self.class??
    self.session_token ||= SecureRandom.hex
    # replace SecureRandom.hex w self.class.generate_session_token
  end
  
  private
  def user_params
    params.require(:user).permit(:emails, :password)
  end
end
