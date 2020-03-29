class AddPaymentInstructionsToServices < ActiveRecord::Migration[6.0]
  def change
    add_column :services, :payment_instructions, :text
  end
end
