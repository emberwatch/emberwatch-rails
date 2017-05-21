module Api
  class AuthenticationsController < BaseController
    skip_after_action :verify_authorized
    skip_after_action :verify_policy_scoped

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
