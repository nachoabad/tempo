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
    date -= 1
    while (date >= Date.today) do
      slots.available_on_date(date).empty? ? (date -= 1) : (return date)
    end
    return nil
  end
end
