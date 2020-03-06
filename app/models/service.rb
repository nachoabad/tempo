class Service < ApplicationRecord
  belongs_to :admin
  has_many :slots,  dependent: :destroy
  has_many :events, through: :slots, dependent: :destroy

  def soonest_available_date(date)
    while slots.available_on_date(date).empty? do
      (date > (Date.today + 99.days)) ? (return nil) : (date += 1)
    end
    date
  end

  def previous_available_date(date)
    while slots.available_on_date(date).empty? do
      (date <= Date.today) ? (return nil) : (date -= 1)
    end
    (date < Date.today) ? (return nil) : date
  end
end
