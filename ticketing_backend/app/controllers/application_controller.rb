class ApplicationController < ActionController::API
  include ::ActionController::Serialization
  include Authenticable
  #include CorsSetup

  # before_filter :cors_preflight_check
  # after_filter :cors_set_access_control_headers




end
