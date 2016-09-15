class ApplicationController < ActionController::API
  include ::ActionController::Serialization
  include ErrorSerializer
  include Authenticable
  include CorsSetup


  before_action :cors_preflight_check
  after_action :cors_set_access_control_headers

  def resp_error(resource, status_code = 422)
    #render json: {errors: resource.errors}, status: status_code, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    render json: ErrorSerializer.serialize(resource.errors), status: status_code
  end




end
