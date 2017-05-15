# Preview all emails at http://localhost:3000/rails/mailers/authentication_mailer
class AuthenticationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/authentication_mailer/sign_in
  def sign_in
    AuthenticationMailerMailer.sign_in
  end

end
