module Authenticable

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render_unauthorized unless user_signed_in?
  end

  def render_unauthorized
    render json: { errors: "Not authenticated" }, status: :unauthorized
  end

  def user_signed_in?
    current_user.present?
  end

end
