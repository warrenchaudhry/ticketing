class ApplicationController < ActionController::API
  include ::ActionController::Serialization
  include ErrorSerializer
  include Authenticable


  def resp_error(resource, status_code = 422)
    #render json: {errors: resource.errors}, status: status_code, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    render json: ErrorSerializer.serialize(resource.errors), status: status_code
  end




end
