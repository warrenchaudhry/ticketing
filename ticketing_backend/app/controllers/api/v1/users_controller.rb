module Api
  module V1
    class UsersController < ApplicationController

      skip_before_action :authenticate_with_token!, only: [:create], raise: false


      before_action :set_user, only: [:show, :update, :destroy]
      before_action :authenticate_with_token!, except: [:create]
      before_action :is_authorized?, only: [:update, :destroy]

      def index
        if current_user.admin?
          @users = User.all

        else
          @users = User.where('id = ?',current_user.id)
        end
        render json: @users, show_auth_token: false
      end

      def show
        render json: @user
      end

      def me
        render json: current_user, show_auth_token: true
      end

      def create
        user = User.create(user_params)
        if user.save
          render json: {user: {email: user.email, password: user.password}}, status: 201
        else
          puts user.errors.messages
          resp_error(user, 422)
        end
      end

      private
        def user_params
          ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:first_name, :last_name, :email, :phone, :password, :password_confirmation, :role])
        end

        def set_user
          @user = User.find(params[:id])
        end

        def is_authorized?
          head :unauthorized unless current_user.admin?
        end

    end
  end
end
