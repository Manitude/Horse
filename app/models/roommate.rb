class Roommate < ActiveRecord::Base

	belongs_to :account, :class_name => 'Account'

	def self.fetch_roommates(email_id)
		# based on email_id get the id 
		# fetch all records present in db based on this id
		where('id = (select id from roommates where email_id = ?)', email_id) if email_id
	end
	
end
