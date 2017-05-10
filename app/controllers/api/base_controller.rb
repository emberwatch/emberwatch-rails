module Api
  class BaseController < ApplicationController
    include Pundit
    include Concerns::ExceptionHandling

    # We have not yet decided on the method to sign-in to emberwatch.com
    # FIXME Authentication needs to be implemented
    def current_user
      nil
    end
  end
end
