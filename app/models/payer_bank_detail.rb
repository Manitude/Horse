class PayerBankDetail < ActiveRecord::Base

	belongs_to :account, :class_name => 'Account'

# +-----------------+--------------+------+-----+---------+----------------+
# | Field           | Type         | Null | Key | Default | Extra          |
# +-----------------+--------------+------+-----+---------+----------------+
# | id              | int(11)      | NO   | PRI | NULL    | auto_increment |
# | email           | varchar(255) | NO   |     | NULL    |                |
# | cardholder_name | varchar(255) | YES  |     | NULL    |                |
# | card_number     | varchar(255) | YES  |     | NULL    |                |
# | valid_till      | varchar(255) | YES  |     | NULL    |                |
# | card_type       | varchar(255) | YES  |     | NULL    |                |
# | account_id      | varchar(255) | NO   |     | NULL    |                |
# | created_at      | datetime     | NO   |     | NULL    |                |
# | updated_at      | datetime     | NO   |     | NULL    |                |
# +-----------------+--------------+------+-----+---------+----------------+
	
end
