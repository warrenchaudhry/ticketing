module Api
  module V1
    class TicketsController < ApplicationController

      before_action :set_ticket, only: [:show, :update, :destroy]
      before_action :authenticate_with_token!
      before_action :is_authorized?, only: [:destroy]


      ##
      # Returns a list of tickets
      #
      # GET /api/v1/tickets
      #
      # Headers: Authorization, token
      # params:
      #
      #
      # = Examples
      #
      #   resp = conn.get("/api/v1/tickets")
      #
      #   resp.status
      #   => 200
      #
      #   resp.body
      #
      # "data": [
      #     {
      #         "id": "1",
      #         "type": "tickets",
      #         "attributes": {
      #             "title": "Ticket No. 1",
      #             "description": "Rem ut laborum error et reiciendis doloremque. Tempore fuga voluptatem. Itaque quaerat dolores.",
      #             "status": "working",
      #             "priority": "low",
      #             "started-at": null,
      #             "resolved-at": null
      #         },
      #         "relationships": {
      #             "reporter": {
      #                 "data": {
      #                     "id": "10",
      #                     "type": "users"
      #                 }
      #             },
      #             "assignee": {
      #                 "data": {
      #                     "id": "4",
      #                     "type": "users"
      #                 }
      #             },
      #             "assignor": {
      #                 "data": {
      #                     "id": "8",
      #                     "type": "users"
      #                 }
      #             }
      #         },
      #         "links": {
      #             "self": "/api/v1/tickets/1"
      #         }
      #     }
      # }
      #
      #
      #
      def index
        fetch_tickets
        if params[:page]
          @tickets = @tickets.page(params[:page][:number]).per(params[:page][:size]).order('created_at DESC')
        else
          @tickets = @tickets.order('created_at DESC')
        end
        render json: @tickets
      end

      def show
        render json: @ticket
      end

      def create
        ticket = Ticket.new(ticket_params)
        if current_user.customer?
          ticket.reporter = current_user
        end
        unless current_user.customer?
          if ticket.assignee_id.present?
            ticket.assignor = current_user
          end
        end

        if ticket.save
          render json: ticket, status: 201
        else
          puts ticket.errors.messages
          resp_error(ticket, 422)
        end
      end

      def update
        if @ticket.update_attributes(ticket_params)
          head :no_content
        else
          resp_error(@ticket, 422)
        end
      end

      private
        def ticket_params
          ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:title, :description, :status, :priority, :status, :priority, :reporter_id, :assignor_id, :assignee_id, :change_status])
        end

        def set_ticket
          @ticket = Ticket.find(params[:id])
        end

        def is_authorized?
          head :unauthorized unless current_user.admin?
        end

        def fetch_tickets
          if current_user.agent?
            tickets = current_user.assigned_tickets
            open_tickets = Ticket.where(status: :open)
            ids = (open_tickets + tickets).collect(&:id).uniq
            @tickets = Ticket.where(id: ids).includes(:reporter, :assignee, :assignor)
          elsif current_user.customer?
            @tickets = current_user.reported_tickets.includes(:reporter, :assignee, :assignor)
          else
            @tickets = Ticket.includes(:reporter, :assignee, :assignor)
          end
        end

    end
  end
end
