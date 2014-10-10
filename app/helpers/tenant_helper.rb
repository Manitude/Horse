module TenantHelper
	
	def reasonable_year_options(options = {})
	  options.reverse_update(:start => 80, :end => 20)
	  {
	    :start_year => (Time.now.year - options[:start]),
	    :end_year   => (Time.now.year - options[:end])
	  }
	end
end
