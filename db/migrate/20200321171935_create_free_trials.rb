class CreateFreeTrials < ActiveRecord::Migration[6.0]
  def change
    create_table :free_trials do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :contact_time

      t.timestamps
    end
  end
end
