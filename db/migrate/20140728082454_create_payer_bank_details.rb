class CreatePayerBankDetails < ActiveRecord::Migration
  def change
    create_table :payer_bank_details do |t|

	  t.string :email, :null => false
	  t.string :cardholder_name
	  t.string :card_number
	  t.string :valid_till
	  t.string :card_type

	  t.integer :account_id, :null => false
	        
      t.timestamps
    end
  end
end
