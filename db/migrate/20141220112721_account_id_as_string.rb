class AccountIdAsString < ActiveRecord::Migration
  def change
  	change_column :accounts, :account_id, :string
  	change_column :invite_roommates, :account_id, :string
  	change_column :issues, :account_id, :string
  	change_column :payer_bank_details, :account_id, :string
  	change_column :payment_histories, :account_id, :string
  	change_column :properties, :account_id, :string
  	change_column :reviews, :account_id, :string

  	add_column :payee_bank_details, :account_id, :string
  	remove_column :payee_bank_details, :property_id
  	
  	remove_column :reviews, :account
  	add_column :reviews, :for_account, :string
  	rename_column :reviews, :property, :for_property
  end
end
