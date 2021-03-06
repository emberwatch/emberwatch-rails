module Api
  class BaseController < ApplicationController
    include Pundit
    include Concerns::ExceptionHandling
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate
    after_action :verify_authorized, except: [:index]
    after_action :verify_policy_scoped, only: :index

    def current_user
      @current_user
    end

    private

    def authenticate
      authenticate_with_http_token do |token, options|
        @current_user = AuthenticationService.validate_token(token) if token
      end
    end
  end
end
