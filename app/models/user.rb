class User < ActiveRecord::Base
  validates :email, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: { message: "Password can't be blank" }
  after_initialize :ensure_session_token
  has_many :subs


  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    if user.nil?
      nil
    else
      (BCrypt::Password.new(user.password_digest).is_password?(password)) ? user : nil
    end
  end

  attr_reader :password
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  private

    def ensure_session_token
      self.session_token ||= SecureRandom::urlsafe_base64
    end

end
