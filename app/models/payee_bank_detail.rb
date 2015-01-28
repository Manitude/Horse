class PayeeBankDetail < ActiveRecord::Base
	belongs_to :account, :class_name => 'Account'

	# +----------------------+--------------+------+-----+---------+----------------+
	# | Field                | Type         | Null | Key | Default | Extra          |
	# +----------------------+--------------+------+-----+---------+----------------+
	# | id                   | int(11)      | NO   | PRI | NULL    | auto_increment |
	# | payee_email          | varchar(255) | YES  |     | NULL    |                |
	# | payee_name           | varchar(255) | NO   |     | NULL    |                |
	# | payee_account_number | varchar(255) | NO   |     | NULL    |                |
	# | payee_ifsc_code      | varchar(255) | YES  |     | NULL    |                |
	# | payee_contact_number | varchar(255) | YES  |     | NULL    |                |
	# | created_at           | datetime     | NO   |     | NULL    |                |
	# | updated_at           | datetime     | NO   |     | NULL    |                |
	# | account_id           | varchar(255) | YES  |     | NULL    |                |
	# +----------------------+--------------+------+-----+---------+----------------+

	def self.fetch_details(email_id)
		where('account_id = (select account_id from properties where id = (select property_id from roommates where email_id = ?))', email_id) if email_id
	end
end
