module Api
  module V1
    class TicketsController < ApplicationController

      before_action :set_ticket, only: [:show, :update, :destroy]
      before_action :authenticate_with_token!
      before_action :is_authorized?, only: [:update, :destroy]

      def index
          fetch_tickets
          render json: @tickets.order(:created_at)
      end

      def show
        render json: @ticket
      end

      def create
        ticket = Ticket.create(ticket_params)
        if ticket.save
          render json: ticket, status: 201
        else
          puts ticket.errors.messages
          resp_error(ticket, 422)
        end
      end

      private
        def ticket_params
          ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:title, :description, :status, :priority, :status, :priority, :reporter_id, :assigned_to, :assigned_by])
        end

        def set_ticket
          @ticket = Ticket.find(params[:id])
        end

        def is_authorized?
          head :unauthorized unless current_user.admin?
        end

        def fetch_tickets
          if current_user.agent?
            @tickets = current_user.assigned_tickets.includes(:reporter, :assignee, :assignor)
          elsif current_user.customer?
            @tickets = current_user.reported_tickets.includes(:reporter, :assignee, :assignor)
          else
            @tickets = Ticket.includes(:reporter, :assignee, :assignor)
          end
        end

    end
  end
end
