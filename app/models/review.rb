class Review < ActiveRecord::Base
# +--------------+--------------+------+-----+---------+----------------+
# | Field        | Type         | Null | Key | Default | Extra          |
# +--------------+--------------+------+-----+---------+----------------+
# | id           | int(11)      | NO   | PRI | NULL    | auto_increment |
# | review       | text         | YES  |     | NULL    |                |
# | rating       | varchar(255) | YES  |     | NULL    |                |
# | for_property | int(11)      | YES  |     | NULL    |                |
# | account_id   | varchar(255) | NO   |     | NULL    |                |
# | created_at   | datetime     | NO   |     | NULL    |                |
# | updated_at   | datetime     | NO   |     | NULL    |                |
# | for_account  | varchar(255) | YES  |     | NULL    |                |
# +--------------+--------------+------+-----+---------+----------------+
end
