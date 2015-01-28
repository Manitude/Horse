class Roommate < ActiveRecord::Base

	belongs_to :property, :class_name => 'Property'

# +---------------------+--------------+------+-----+---------+----------------+
# | Field               | Type         | Null | Key | Default | Extra          |
# +---------------------+--------------+------+-----+---------+----------------+
# | id                  | int(11)      | NO   | PRI | NULL    | auto_increment |
# | property_id         | int(11)      | YES  |     | NULL    |                |
# | name                | varchar(255) | YES  |     | NULL    |                |
# | contact_no          | varchar(255) | YES  |     | NULL    |                |
# | bank_account_number | varchar(255) | YES  |     | NULL    |                |
# | ifsc                | varchar(255) | YES  |     | NULL    |                |
# | email_id            | varchar(255) | YES  |     | NULL    |                |
# | primary_tenant      | tinyint(1)   | YES  |     | NULL    |                |
# | created_at          | datetime     | NO   |     | NULL    |                |
# | updated_at          | datetime     | NO   |     | NULL    |                |
# | rent_paid_for       | datetime     | YES  |     | NULL    |                |
# +---------------------+--------------+------+-----+---------+----------------+


	def self.fetch_roommates(email_id)
		# based on email_id get the property_id 
		# fetch all records present in db based on this id
		where('property_id = (select property_id from roommates where email_id = ?)', email_id) if email_id
	end

	def self.get_rm_detail(email_id)
		where('email_id =', email_id) if email_id
	end

	def update_rm_detail!(property_id)
		update_attributes(:property_id => property_id, :primary_tenant => 0)
	end

	def update_status_for_current_month!
		update_attributes(:paid_for_current_month => true)
	end

	def set_as_primary_tenant!
		update_attributes(:primary_tenant => 1)
	end
end
