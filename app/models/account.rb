class Account < ActiveRecord::Base

  has_many :properties
  has_many :issues
  has_many :payer_bank_details
  has_many :payment_histories
  has_many :invite_roommates

  has_one :payee_bank_details

# +--------------------+--------------+------+-----+---------+----------------+
# | Field              | Type         | Null | Key | Default | Extra          |
# +--------------------+--------------+------+-----+---------+----------------+
# | id                 | int(11)      | NO   | PRI | NULL    | auto_increment |
# | name               | varchar(255) | YES  |     | NULL    |                |
# | email              | varchar(255) | YES  |     | NULL    |                |
# | contact_number     | varchar(255) | YES  |     | NULL    |                |
# | pan                | varchar(255) | YES  |     | NULL    |                |
# | birth_date         | datetime     | YES  |     | NULL    |                |
# | user_type          | varchar(255) | YES  |     | NULL    |                |
# | pin_code           | varchar(255) | YES  |     | NULL    |                |
# | photo_file_name    | varchar(255) | YES  |     | NULL    |                |
# | gender             | varchar(255) | YES  |     | NULL    |                |
# | emergency_contact  | varchar(255) | YES  |     | NULL    |                |
# | pet                | tinyint(1)   | YES  |     | 0       |                |
# | smoking_drinking   | tinyint(1)   | YES  |     | 0       |                |
# | eating_preferences | varchar(255) | YES  |     | NULL    |                |
# | review             | text         | YES  |     | NULL    |                |
# | created_at         | datetime     | NO   |     | NULL    |                |
# | updated_at         | datetime     | NO   |     | NULL    |                |
# | account_id         | varchar(255) | NO   |     | NULL    |                |
# | rating             | int(11)      | YES  |     | NULL    |                |
# +--------------------+--------------+------+-----+---------+----------------+

end
