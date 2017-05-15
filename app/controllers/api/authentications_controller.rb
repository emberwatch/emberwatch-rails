module Api
  class AuthenticationsController < BaseController
    def create
      user          = User.find_or_create_by!(email: params[:email])
      authenticator = AuthenticationService.new(user)
      email         = user.email
      token         = authenticator.create_token
      AuthenticationMailer.sign_in(email, token).deliver_now
      head :no_content
    end
  end
end
