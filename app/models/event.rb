class Event < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :slot

  validates :date, presence: true
  validates :slot, uniqueness: { scope: :date }

  delegate :hour, :min, :service, to: :slot

  enum status: [:pending, :confirmed, :blocked]
  
  default_scope { order(:date) }

  scope :on_date, ->(date) { where(date: date) }
end
