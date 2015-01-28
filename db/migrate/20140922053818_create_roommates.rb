class CreateRoommates < ActiveRecord::Migration
  def change
    create_table :roommates do |t|

      t.integer :account_id, :null => false
      t.string :name, :null => false
      t.integer :contact_no
      t.string :bank_account_number
      t.string :ifsc
      t.string :email_id
      t.boolean :primary_tenant
      t.datetime :payment_due_date
      t.datetime :payment_done_at
      
      t.timestamps
    end
  end
end
