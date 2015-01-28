class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|

      t.text :review
      t.string :rating
      t.integer :account
      t.integer :property
      t.integer :account_id, :null => false

      t.timestamps
    end
  end
end
