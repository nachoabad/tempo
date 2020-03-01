class Service < ApplicationRecord
  belongs_to :admin
  has_many :events, dependent: :destroy
  has_many :slots,  dependent: :destroy

  def soonest_available_date(date)
    while slots.for_date(date).empty? do
      date += 1
    end
    date
  end

  def latest_available_date(date)
    while slots.for_date(date).empty? do
      (date <= Date.today) ? (return nil) : (date -= 1)
    end
    date
  end
end
