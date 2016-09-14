class SessionsController < ApplicationController

  skip_before_action :authenticate_with_token!, only: [:create], raise: false


  def create
    user_password = params[:user][:password]
    user_email    = params[:user][:email]
    user = user_email.present? && User.find_by(email: user_email)
    if user.present? && user.valid_password?(user_password)
      #user.generate_authentication_token!
      #user.save(validate: false)
      #render json: user, show_auth_token: true, status: 200
      data = {
        token: user.auth_token,
        email: user.email
      }
      render json: data, status: 201 and return
    else
      #render json: { errors: [{status: '422', detail: 'Invalid email or password'}]}, status: 422
      render json: { errors: 'Invalid email or password' }, status: 422
    end
  end


  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_authentication_token!
    user.save
    head 204
  end

end
