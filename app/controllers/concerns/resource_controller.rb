module Concerns
  module ResourceController
    extend ActiveSupport::Concern
    include ActiveModelSerializers::Deserialization

    included do
      cattr_accessor :resource_scope

      before_action :set_resource,     only: %i(show update destroy)
      before_action :apply_id_filters, only: :index
    end

    def index
      @resources = policy_scope(resource_scope).ransack(params[:filter])
                                               .result(distinct: true)
      render json: @resources, include: params[:include]
    end

    def show
      render json: @resource, include: params[:include]
    end

    def create
      @resource = resource_scope.new resource_params
      authorize @resource
      @resource.save!
      render json: @resource
    end

    def update
      @resource.assign_attributes resource_params
      authorize @resource
      @resource.save!
      render json: @resource
    end

    def destroy
      @resource.destroy!
      render json: @resource
    end

    private

    def resource_param_name
      @resource_param_name ||= resource_scope.to_s.underscore.to_sym
    end

    def resource_params
      return @resource_params if @resource_params

      object = @resource || resource_scope
      object_policy = policy(object)
      permitted_attributes = object_policy.permitted_params
      whitelisted_attributes = object_policy.whitelisted_params
      jsonapi_params = jsonapi_parse(params)
      resource_params = ActionController::Parameters.new jsonapi_params
      @resource_params = resource_params
                         .permit(permitted_attributes)
                         .tap do |whitelisted|
                           whitelisted_attributes.each do |key|
                             data = resource_params[key].permit!.to_h
                             whitelisted[key] = data if data.present?
                           end
                         end
    end

    def set_resource
      @resource = policy_scope(resource_scope).find params[:id]
      authorize @resource
    end

    def apply_id_filters
      params[:filter] ||= {}

      if params.has_key? :ids and params[:ids].kind_of? Array
        params[:filter][:id_in] = params[:ids]
      end
    end
  end
end
