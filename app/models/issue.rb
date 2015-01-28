class Issue < ActiveRecord::Base

  belongs_to :account, :class_name => 'Account'

# +----------------+---------------+------+-----+---------+----------------+
# | Field          | Type          | Null | Key | Default | Extra          |
# +----------------+---------------+------+-----+---------+----------------+
# | id             | int(11)       | NO   | PRI | NULL    | auto_increment |
# | reported_by    | datetime      | YES  |     | NULL    |                |
# | reporting_date | datetime      | YES  |     | NULL    |                |
# | resolved_date  | datetime      | YES  |     | NULL    |                |
# | status         | varchar(255)  | YES  |     | NULL    |                |
# | account_id     | varchar(255)  | NO   |     | NULL    |                |
# | created_at     | datetime      | NO   |     | NULL    |                |
# | updated_at     | datetime      | NO   |     | NULL    |                |
# | severity       | varchar(60)   | YES  |     | NULL    |                |
# | description    | varchar(1000) | YES  |     | NULL    |                |
# +----------------+---------------+------+-----+---------+----------------+

end
