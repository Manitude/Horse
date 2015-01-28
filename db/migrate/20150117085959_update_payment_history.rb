class UpdatePaymentHistory < ActiveRecord::Migration
  def change
  	remove_column :payment_histories, :tenant_email
  	remove_column :payment_histories, :payment_due_date
  	remove_column :payment_histories, :status

  	rename_column :payment_histories, :landlord_email, :landlord_name
  
  	add_column :payment_histories, :postal_address, :string
  	add_column :payment_histories, :landlord_PAN, :string
  end
end
