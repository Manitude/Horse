class PaymentHistory < ActiveRecord::Base

	belongs_to :account, :class_name => 'Account'

# +---------------------+--------------+------+-----+---------+----------------+
# | Field               | Type         | Null | Key | Default | Extra          |
# +---------------------+--------------+------+-----+---------+----------------+
# | id                  | int(11)      | NO   | PRI | NULL    | auto_increment |
# | landlord_name       | varchar(255) | YES  |     | NULL    |                |
# | property_id         | varchar(255) | NO   |     | NULL    |                |
# | amount              | varchar(255) | NO   |     | NULL    |                |
# | purpose             | varchar(255) | NO   |     | rent    |                |
# | payment_done_at     | datetime     | YES  |     | NULL    |                |
# | payment_mode        | varchar(255) | NO   |     | NULL    |                |
# | payment_received_at | datetime     | YES  |     | NULL    |                |
# | account_id          | varchar(255) | NO   |     | NULL    |                |
# | created_at          | datetime     | NO   |     | NULL    |                |
# | updated_at          | datetime     | NO   |     | NULL    |                |
# | late                | tinyint(1)   | YES  |     | NULL    |                |
# | pending             | tinyint(1)   | YES  |     | NULL    |                |
# | successful          | tinyint(1)   | YES  |     | NULL    |                |
# | postal_address      | varchar(255) | YES  |     | NULL    |                |
# | landlord_PAN        | varchar(255) | YES  |     | NULL    |                |
# +---------------------+--------------+------+-----+---------+----------------+


end
