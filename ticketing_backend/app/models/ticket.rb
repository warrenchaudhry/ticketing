class Ticket < ApplicationRecord
  STATUSES = [:open, :inprogress, :closed, :rejected].freeze
  PRIORITIES = [:low, :medium, :high].freeze

  belongs_to :reporter, class_name: 'User', foreign_key: :reporter_id
  belongs_to :assignee, class_name: 'User', foreign_key: :assigned_to
  belongs_to :assignor, class_name: 'User', foreign_key: :assigned_by

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :reporter, presence: true

  enum status: STATUSES
  enum priority: PRIORITIES

  default_scope { order(status: 'ASC', updated_at: 'DESC') }
end
