class CreatePayeeBankDetails < ActiveRecord::Migration
  def change
    create_table :payee_bank_details do |t|

      t.string :payee_name, :null => false
      t.string :payee_account_number, :null => false
      t.string :payee_ifsc_code
      t.integer :payee_contact_number
      t.string :payee_email_id
      t.integer :account_id, :null => false
      
      t.timestamps
    end
  end
end
