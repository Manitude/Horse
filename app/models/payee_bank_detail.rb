class PayeeBankDetail < ActiveRecord::Base

	belongs_to :account, :class_name => 'Account'

end
