class Event < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :slot

  accepts_nested_attributes_for :user, update_only: true

  validates :date, presence: true
  validates :slot, uniqueness: { scope: :date }
  validate :date_in_slot

  delegate :name, to: :service
  delegate :display, :service, to: :slot

  enum status: [:pending, :confirmed, :blocked]
  
  default_scope { order(:date) }

  scope :on_date,  ->(date) { where(date: date) }
  scope :upcoming, -> { where("date >= ?", Date.today) }

  def button_class
    blocked? ? 'btn-outline-danger' : 'btn-success'
  end

  private

  def date_in_slot
    errors.add(:date, 'date outside slot') unless slot.day == date.wday
  end
end
