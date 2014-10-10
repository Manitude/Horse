class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|

      t.string :tenant_email, :null => false
      t.string :landlord_email
      t.string :property_id, :null => false
      t.datetime :reported_by
      t.datetime :reporting_date
      t.datetime :resolved_date
      t.string :status

      t.integer :account_id, :null => false
      
      t.timestamps
    end
  end
end
