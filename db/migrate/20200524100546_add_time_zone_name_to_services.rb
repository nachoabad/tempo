class AddTimeZoneNameToServices < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :time_zone_name, :string
  end
end
