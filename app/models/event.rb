class Event < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :slot

  accepts_nested_attributes_for :user, update_only: true

  validates :date, presence: true
  validates :slot, uniqueness: { scope: :date }
  validate :date_in_slot

  delegate :hour, :min, :service, to: :slot

  enum status: [:pending, :confirmed, :blocked]
  
  default_scope { order(:date) }

  scope :on_date, ->(date) { where(date: date) }

  private

  def date_in_slot
    errors.add(:date, 'date outside slot') unless slot.day == date.wday
  end
end
