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

  # def html
  #   markdown.render(object.description)
  # end
  #
  # def edited
  #   !object.versions.empty?
  # end

  # def status_raw
  #   object.status_before_type_cast
  # end
  #
  # protected
  #
  # def renderer
  #   Redcarpet::Render::HTML.new(safe_links_only: true, prettify: true,
  #                               escape_html: true)
  # end
  #
  # def markdown
  #   Redcarpet::Markdown.new(renderer,
  #                           no_intra_emphasis: true,
  #                           tables: true,
  #                           fenced_code_blocks: true,
  #                           autolink: true,
  #                           strikethrough: true,
  #                           lax_spacing: true,
  #                           space_after_headers: true,
  #                           underline: true,
  #                           highlight: true,
  #                           quote: true)
  # end
end
