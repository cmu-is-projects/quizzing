class PasswordManager
  include ActiveModel::Model

  def initialize(user)
    @user = user
  end

  attr_reader :user

  def self.from_email(email)
    new User.find_by_email(email.downcase)
  end

  def self.from_token(token)
    au = User.find_by_password_reset_token(token)
    if au.nil?
      raise Exceptions::NoPasswordResetToken
    else
      new au
    end
  end

  def send_reset_email(subdomain)
    generate_token
    user.token_type = "reset"
    user.password_reset_sent_at = Time.zone.now
    user.save!
    PostOffice.reset_password_msg(user, subdomain).deliver
  end

  def expired?
    if user.token_type == 'new'
      user.password_reset_sent_at < 8.days.ago
    else
      user.password_reset_sent_at < 64.minutes.ago
    end
  end

  def generate_token
    user.password_reset_token = SecureRandom.hex
  end

  def for_new_user(subdomain)
    generate_token
    user.token_type = "new"
    user.password_reset_sent_at = Time.zone.now
    user.save!
    if user.role == "coach"
      PostOffice.new_coach_msg(user, subdomain).deliver
    else
      PostOffice.new_admin_msg(user, subdomain).deliver
    end
  end

end
