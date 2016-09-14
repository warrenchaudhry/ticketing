module Api
  module V1
    class TicketsController < ApplicationController

      before_action :set_ticket, only: [:show, :update, :destroy]
      before_action :authenticate_with_token!
      before_action :is_authorized?, only: [:update, :destroy]

      def index
          fetch_tickets
          render json: @tickets
      end

      def show
        render json: @ticket
      end

      private
        def ticket_params
          ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:first_name, :last_name, :email, :phone, :password, :password_confirmation, :role])
        end

        def set_ticket
          @ticket = Ticket.find(params[:id])
        end

        def is_authorized?
          head :unauthorized unless current_user.admin?
        end

        def fetch_tickets
          if current_user.agent?
            @tickets = current_user.assigned_tickets
          elsif current_user.customer?
            @tickets = current_user.reported_tickets
          else
            @tickets = Ticket.all
          end
        end

    end
  end
end
