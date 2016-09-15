module Api
  module V1
    class UsersController < ApplicationController

      skip_before_action :authenticate_with_token!, only: [:create], raise: false

      before_action :set_user, only: [:show, :update, :destroy]
      before_action :is_authorized?, only: [:index, :destroy]

      def index
        @users = User.order(:first_name)
        if params[:filter].present?
          if params[:filter][:role].present? && ['customer', 'admin', 'agent'].include?(params[:filter][:role])
            @users = @users.send(params[:filter][:role].pluralize).order(:first_name)
          end
        else
          @users = User.where.not(id: current_user.id).order(:first_name).with_any_role(:admin, :agent)
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
          render json: user, status: 201
        else
          puts user.errors.messages
          resp_error(user, 422)
        end
      end

      def update

      end

      def destroy

      end


      private
        def user_params
          ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:first_name, :last_name, :email, :phone, :password, :password_confirmation, :role])
        end

        def set_user
          @user = User.find(params[:id])
        end

        def is_authorized?
          head :unauthorized if current_user.customer?
        end

    end
  end
end
