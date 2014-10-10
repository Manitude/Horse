class CreatePaymentHistories < ActiveRecord::Migration
  def change
    create_table :payment_histories do |t|

      t.string :tenant_email, :null => false
      t.string :landlord_email
      t.string :property_id
      t.string :amount, :null => false
      t.string :purpose, :default => "rent"
      t.datetime :payment_due_date
      t.datetime :payment_done_at
      t.string :payment_mode
      t.datetime :payment_received_at
      t.boolean :late
      t.boolean :pending
      t.boolean :successful

      t.integer :account_id, :null => false

      t.timestamps
    end
  end
end
