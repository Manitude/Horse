module TenantHelper
	
	def reasonable_year_options(options = {})
	  options.reverse_update(:start => 80, :end => 20)
	  {
	    :start_year => (Time.now.year - options[:start]),
	    :end_year   => (Time.now.year - options[:end])
	  }
	end

	def resource_name
	  :user
	end

	def resource
	  @resource ||= User.new
	end

	def devise_mapping
	  @devise_mapping ||= Devise.mappings[:user]
	end

	def options_for_rent_payable_date(selected = nil)
    	options = (1...29).to_a.map{|l| ["#{l.ordinalize}"+" of every month",l]}
    	options_for_select(options,selected)
  	end
end
