class TicketSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :priority, :started_at, :resolved_at

  # has_many :responses do
  #   link(:related) do
  #     href ticket_responses_path(object)
  #     meta count: object.responses_count
  #   end
  #
  #   include_data false
  # end

  link(:self) { api_v1_ticket_path(object) }

  belongs_to :reporter
  belongs_to :assignee
  belongs_to :assignor
end
