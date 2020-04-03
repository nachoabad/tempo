class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :slug
      t.string :time_zone
      t.integer :status, default: 0
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end

    add_index :services, :slug
    add_index :services, :status
  end
end
