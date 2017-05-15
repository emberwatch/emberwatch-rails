class AuthenticationMailer < ApplicationMailer
  def sign_in(email, token)
    @token = token
    mail to: email
  end
end
