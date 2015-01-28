class InviteRoommate < ActiveRecord::Base

	belongs_to :account, :class_name => 'Account'

# +-----------------+--------------+------+-----+---------+----------------+
# | Field           | Type         | Null | Key | Default | Extra          |
# +-----------------+--------------+------+-----+---------+----------------+
# | id              | int(11)      | NO   | PRI | NULL    | auto_increment |
# | sender_email    | varchar(255) | NO   |     | NULL    |                |
# | invitee_email   | varchar(255) | NO   |     | NULL    |                |
# | acceptance      | tinyint(1)   | YES  |     | NULL    |                |
# | acceptance_date | datetime     | YES  |     | NULL    |                |
# | account_id      | varchar(255) | NO   |     | NULL    |                |
# | created_at      | datetime     | NO   |     | NULL    |                |
# | updated_at      | datetime     | NO   |     | NULL    |                |
# +-----------------+--------------+------+-----+---------+----------------+


	def update_invitation(response)
		update_attributes(:acceptance => response, :acceptance_date => Time.now)
	end
end
