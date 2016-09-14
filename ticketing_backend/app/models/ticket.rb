class Ticket < ApplicationRecord
  STATUSES = [:open, :pending, :rejected, :closed].freeze
  PRIORITIES = [:low, :medium, :high].freeze

  belongs_to :reporter, class_name: 'User', foreign_key: :reporter_id
  belongs_to :assignee, class_name: 'User', foreign_key: :assigned_to, optional: true
  belongs_to :assignor, class_name: 'User', foreign_key: :assigned_by, optional: true

  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  # validates :reporter_id, presence: true

  enum status: STATUSES
  enum priority: PRIORITIES

  default_scope { order(status: 'ASC', updated_at: 'DESC') }

  before_save :assign_defaults

  def assign_defaults
    if priority.blank?
      self.priority = :low
    end
    if new_record?
      self.status = :open
    end
  end
end
