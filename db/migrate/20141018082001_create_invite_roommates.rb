class CreateInviteRoommates < ActiveRecord::Migration
  def change
    create_table :invite_roommates do |t|
      t.string :sender_email, :null => false
      t.string :invitee_email, :null => false
      t.boolean :acceptance
      t.datetime :acceptance_date
      
      t.integer :account_id, :null => false

      t.timestamps
    end
  end
end
