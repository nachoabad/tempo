class CreateSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :slots do |t|
      t.integer :day
      t.integer :hour
      t.integer :min
      t.integer :status
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end

    add_index :slots, :status
  end
end
