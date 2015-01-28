class AddRatingColToPropertyAndAccount < ActiveRecord::Migration
  def change
  	add_column :accounts, :rating, :integer
  	add_column :properties, :rating, :integer
  end
end
