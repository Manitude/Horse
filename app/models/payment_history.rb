class PaymentHistory < ActiveRecord::Base

	belongs_to :account, :class_name => 'Account'
	
end