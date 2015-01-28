class UpdateAllMyTables < ActiveRecord::Migration
  def change
  	remove_column :roommates, :account_id
  	remove_column :roommates, :name
  	remove_column :roommates, :contact_no
  	remove_column :roommates, :payment_due_date
  	remove_column :roommates, :payment_done_at
	  remove_column :payee_bank_details, :payee_email_id
  	
  	add_column :roommates, :property_id, :integer
  	add_column :roommates, :name, :string
  	add_column :roommates, :contact_no, :string  	
  	add_column :roommates, :rent_paid_for, :datetime
  	add_column :payment_histories, :status, :string
  	add_column :payee_bank_details, :payee_email, :string
  	add_column :accounts, :rating, :string
  end
end
