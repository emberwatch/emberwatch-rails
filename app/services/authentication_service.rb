class AuthenticationService
  attr_reader :user

  class <<self
    def validate_token(token)
      secret      = Rails.application.secrets.secret_key_base
      payload, *_ = JWT.decode token, secret, 'HS256'
      User.where(email: payload['eml']).first!
    rescue JWT::DecodeError => e
      Rails.logger.error(e)
      nil
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.error(e)
      nil
    end
  end

  def initialize(user)
    @user = user
  end

  def create_token
    secret = Rails.application.secrets.secret_key_base
    JWT.encode token_payload, secret, 'HS256'
  end

  private

  def token_payload
    {
      eml: user.email,
      exp: 1.day.from_now.to_i
    }
  end
end
