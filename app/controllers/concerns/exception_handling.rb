module Concerns
  module ExceptionHandling
    module InstanceMethods
      # Override Rails 404 responder, to return a custom JSON message.
      def record_not_found(exception)
        render json: {
                 status: 404,
                 message: exception.message.to_s
               },
               status: :not_found
      end

      # If a record cannot be saved, because it is either malformed or some
      # callback failed, an error message containing the record's errors is
      # returned.
      def record_invalid(exception)
        errors = exception.record.errors.as_json

        render json: {
                 status: 422,
                 message: 'Unprocessable entity',
                 errors: errors
               },
               status: :unprocessable_entity
      end

      # Custom handler for a 400 - Bad request error
      def bad_request
        render json: {
                 status: 400,
                 message: 'Bad request'
               },
               status: :bad_request
      end

      # Custom handler for unauthorized access
      def unauthorized_request
        render json: {
                   status: 403,
                   message: 'Unauthorized access'
                 },
                 status: 403
      end
    end

    def self.included(rec)
      rec.send :include, InstanceMethods

      # Exception handling
      rec.rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
      rec.rescue_from ActiveRecord::RecordInvalid,  with: :record_invalid
      rec.rescue_from ActiveRecord::RecordNotSaved, with: :record_invalid
      rec.rescue_from Pundit::NotAuthorizedError,   with: :unauthorized_request
    end
  end
end
