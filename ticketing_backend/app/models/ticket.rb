class Ticket < ApplicationRecord
  STATUSES = [:open, :working, :rejected, :resolved, :closed].freeze
  PRIORITIES = [:low, :medium, :high].freeze

  attr_accessor :change_status
  belongs_to :reporter, class_name: 'User', foreign_key: :reporter_id, optional: true
  belongs_to :assignee, class_name: 'User', foreign_key: :assignee_id, optional: true
  belongs_to :assignor, class_name: 'User', foreign_key: :assignor_id, optional: true

  validates :title, :description, :status, presence: true, unless: 'change_status.present?'
  validates :reporter_id, presence: true#, unless: 'change_status.present?'

  enum status: STATUSES
  enum priority: PRIORITIES

  # default_scope { order(status: 'ASC', updated_at: 'DESC') }

  before_save :assign_defaults

  def assign_defaults
    if priority.blank?
      self.priority = :low
    end
    if new_record? && status.blank?
      self.status = :open
    end
    if status_changed? && status == 'working'
      self.started_at = Time.zone.now
    end
    if persisted? && status_changed? && status == 'open'
      self.assignee_id = nil
    end
    if status_changed? && status == 'resolved'
      self.resolved_at = Time.zone.now
    end
  end

end
