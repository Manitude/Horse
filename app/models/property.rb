class Property < ActiveRecord::Base
	has_many :roommates
	belongs_to :account, :class_name => 'Account'

# +----------------------+--------------+------+-----+---------+----------------+
# | Field                | Type         | Null | Key | Default | Extra          |
# +----------------------+--------------+------+-----+---------+----------------+
# | id                   | int(11)      | NO   | PRI | NULL    | auto_increment |
# | owner_email          | varchar(255) | YES  |     | NULL    |                |
# | owner_contact        | varchar(255) | YES  |     | NULL    |                |
# | tenant_email         | varchar(255) | YES  |     | NULL    |                |
# | description          | text         | YES  |     | NULL    |                |
# | pin_code             | varchar(255) | YES  |     | NULL    |                |
# | postal_address       | text         | YES  |     | NULL    |                |
# | landmark             | varchar(255) | YES  |     | NULL    |                |
# | area                 | varchar(255) | YES  |     | NULL    |                |
# | city                 | varchar(255) | YES  |     | NULL    |                |
# | state                | varchar(255) | YES  |     | NULL    |                |
# | lease_type           | varchar(255) | YES  |     | NULL    |                |
# | rent                 | int(11)      | YES  |     | NULL    |                |
# | deposit              | int(11)      | YES  |     | NULL    |                |
# | built_up_area        | int(11)      | YES  |     | NULL    |                |
# | furnishing           | varchar(255) | YES  |     | NULL    |                |
# | water_supply_type    | varchar(255) | YES  |     | NULL    |                |
# | direction_facing     | varchar(255) | YES  |     | NULL    |                |
# | bedroom              | int(11)      | YES  |     | NULL    |                |
# | bathroom             | int(11)      | YES  |     | NULL    |                |
# | ac                   | int(11)      | YES  |     | NULL    |                |
# | tv                   | tinyint(1)   | YES  |     | NULL    |                |
# | wardrobe             | tinyint(1)   | YES  |     | NULL    |                |
# | dining_table         | tinyint(1)   | YES  |     | NULL    |                |
# | parking              | tinyint(1)   | YES  |     | NULL    |                |
# | refrigerator         | tinyint(1)   | YES  |     | NULL    |                |
# | geyser               | tinyint(1)   | YES  |     | NULL    |                |
# | sofa                 | tinyint(1)   | YES  |     | NULL    |                |
# | gas_pipeline         | tinyint(1)   | YES  |     | NULL    |                |
# | gym                  | tinyint(1)   | YES  |     | NULL    |                |
# | swimming_pool        | tinyint(1)   | YES  |     | NULL    |                |
# | lift                 | tinyint(1)   | YES  |     | NULL    |                |
# | washing_machine      | tinyint(1)   | YES  |     | NULL    |                |
# | microwave            | tinyint(1)   | YES  |     | NULL    |                |
# | album_folder_name    | varchar(255) | YES  |     | NULL    |                |
# | rent_agreement_terms | text         | YES  |     | NULL    |                |
# | rent_due_date        | int(11)      | YES  |     | NULL    |                |
# | notes                | text         | YES  |     | NULL    |                |
# | review               | text         | YES  |     | NULL    |                |
# | account_id           | varchar(255) | YES  |     | NULL    |                |
# | created_at           | datetime     | NO   |     | NULL    |                |
# | updated_at           | datetime     | NO   |     | NULL    |                |
# | rating               | int(11)      | YES  |     | NULL    |                |
# +----------------------+--------------+------+-----+---------+----------------+

	def self.get_property_id(email_id)
		prop_id = Roommate.find_by_email_id(email_id).property_id if email_id
		rm = Property.find_by_id(prop_id)
		rm.id if rm
	end

	def self.fetch_property_details(email_id)
		prop_id = Roommate.find_by_email_id(email_id).property_id if email_id
		rm = Property.find_by_id(prop_id)
	end

	# private
	# throwing NoMethodError hence commenting
	# def fetch_property_id(email)
	# 	return Roommate.find_by_email_id(email).property_id if email
	# end

end