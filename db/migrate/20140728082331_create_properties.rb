class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|

      t.string :owner_email
      t.integer :owner_contact
      t.string :tenant_email
      t.text :description
      t.integer :pin_code
      t.text :postal_address
      t.string :landmark
      t.string :area
      t.string :city
      t.string :state
      t.string :lease_type
      t.integer :rent
      t.integer :deposit
      t.integer :built_up_area
      t.string :furnishing
      t.string :water_supply_type
      t.string :direction_facing
      t.integer :bedroom
      t.integer :bathroom
      t.integer :ac
      t.boolean :tv
      t.boolean :wardrobe
      t.boolean :dining_table
      t.boolean :parking
      t.boolean :refrigerator
      t.boolean :geyser
      t.boolean :sofa
      t.boolean :gas_pipeline
      t.boolean :gym
      t.boolean :swimming_pool
      t.boolean :lift
      t.boolean :washing_machine
      t.boolean :microwave
      t.string :album_folder_name
      t.text :rent_agreement_terms
      t.datetime :rent_due_date
      t.text :notes
      t.text :review

      t.integer :account_id, :null => false
      
      t.timestamps
    end
  end
end
