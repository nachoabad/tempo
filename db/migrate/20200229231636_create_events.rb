class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.date :date
      t.string :note
      t.integer :status, default: 0, null: false
      t.references :slot, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :events, :status
    add_index :events, [:slot_id, :date], unique: true
  end
end
