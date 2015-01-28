class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|

      t.string :first_name
      t.string :last_name
      t.string :email, :null => false
      t.integer :contact_number
      t.string :pan
      t.datetime :birth_date
      t.string :user_type
      t.integer :pin_code, :limit =>6
      t.string :photo_file_name
      t.string :gender
      t.integer :emergency_contact
      t.boolean :pet , :default => false
      t.boolean :smoking_drinking , :default => false
      t.string :eating_preferences
      t.text :review

      t.integer :account_id, :null => false
      
      t.timestamps
    end
  end
end
