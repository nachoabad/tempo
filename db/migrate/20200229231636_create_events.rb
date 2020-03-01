class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.time :time
      t.string :note
      t.integer :status
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
