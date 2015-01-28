class UpdateForRoommateLogic < ActiveRecord::Migration
  def change

  	rename_column :accounts, :first_name, :name
  	remove_column :accounts, :last_name
  	change_column :accounts, :email, :string, :null => true
  	change_column :properties, :account_id, :integer, :null => true
  	remove_column :payee_bank_details, :account_id
  	add_column :payee_bank_details, :property_id, :integer

  	change_column :accounts, :contact_number, :string
  	change_column :accounts, :pin_code, :string
  	change_column :accounts, :emergency_contact, :string

  	change_column :properties, :owner_contact, :string
  	change_column :properties, :pin_code, :string

  	change_column :payee_bank_details, :payee_contact_number, :string

  	change_column :roommates, :contact_no, :string

  end
end
