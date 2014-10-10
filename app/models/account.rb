class Account < ActiveRecord::Base

  has_many :properties
  has_many :issues
  has_many :payer_bank_details
  has_many :payment_histories
  has_many :roommates

  has_one :payee_bank_details

end
