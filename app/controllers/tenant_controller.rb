class TenantController < ApplicationController
  before_filter :authenticate_user!
	layout 'tenant'
  def index
    # determine if user has logged in for the first time!
      # This can be done by checking payee's bank detail for the concerned tenant.

    # if the user has no info saved, take him to first_time_flow else render index(pay now) page.
    payee_bank_detail = PayeeBankDetail.where(["account_id = ?", current_user.id]).last
    render :layout => 'application', :template => 'register_tenant/landlord_bank_detail.html.erb' if !payee_bank_detail
  end
  def pay_rent


    # gets triggered when user clicks pay now button.
    # create a new row in PaymentHistory 
    payment_done_at = Time.current
    payment_details = params[:payment_details]
    late = payment_done_at - payment_details["payment_due_date"] == 1 ? true : false
    pending, successful = true, false
    landlord_name = PayeeBankDetail.where(:id => current_user["id"]).pluck(:payee_name)
    payment_details.merge!({:payment_done_at => payment_done_at, :account_id => current_user["id"], :tenant_email => current_user["email"], :late => late, :pending => pending, :successful => successful, :landlord_email => landlord_name})
    @roommate_detail = Roommate.create!(roommate_details)
  end
  def roommate
    # finds list of all roommates added by the primary tenant 
    @roommate_data = Roommate.fetch_roommates(current_user["email"])
  end
  def edit_roommate_details
    # list down all the information from roommates.rb model and present them in a tabular column.
  end
  def save_property_details
  end
  def pay_rent_through_credit
  	# If remember me is clicked, save the credit card details in payer_bank_details
  		#If not, delete the records from db.
  	# make an API call to the payment Gateway and render appropriate view based on the response from PG!
  	# If the payment is successful, show him a success msg and keep the user in index page.
  		# Also update the same in payment history.
  	# If the payment fails, show him a failure msg and keep the user in index page.
  	redirect_to(:action => 'index')
  end
  def pay_rent_through_debit
  	# If remember me is clicked, save the credit card details in payer_bank_details
  		#If not, delete the records from db.
  	# make an API call to the payment Gateway and render appropriate view based on the response from PG!
  	# If the payment is successful, show him a success msg and keep the user in index page.
  		# Also update the same in payment history.
  	# If the payment fails, show him a failure msg and keep the user in index page.
  	redirect_to(:action => 'index')
  end
  def payment_history
  	# fetches all records present in payment history table.

  	#If any of the rows are edited, then save the updated rows in db and return the same view with success msg.
    @payment_data = PaymentHistory.find(:all)
    if @payment_data
      late, pending, successful = 0, 0, 0
      @payment_data.each_value do |data|
        late = late + (data["payment_done_at"] - data["payment_due_date"])
        pending = 1 if data["payment_received_at"]
      end
      successful = PaymentHistory.count('id') - pending
    end
  end
  def issue
  	# Fetches two lists of issue from issue table, and render a view displaying both.
    @issue_list = Issue.find(:all)
  	#if any of the rows are edited, then save the updated rows in the db and return the same view with success msg.
  end
  def report_issue
  	# Creates a new issue and saves it to the db. A success msg is displayed in case of a successful save.
  end
  def save_user_info
  	debugger
  	# Saves the user info into the account table, with user type as Tenant.

  		# Not sure how to save profile pic.
  	redirect_to(:action => 'profile')
  end
  def payee_detail
  	# Saves the payee bank details into the payee_bank_detail table.
  end
  def property_detail
  	# Saves the property details into the payee_bank_detail table.
  end

  def save_landlord_bank_info
    debugger
    bank_details = params[:bank_details]

    roommate_details = {:account_id => current_user["id"], :email_id => current_user["email"], :primary_tenant => true, :name => bank_details["name"], :bank_account_number => bank_details["bank_account_number"], :ifsc => bank_details["ifsc"], :contact_no => bank_details["contact_no"]}
    Roommate.create!(roommate_details)

    bank_details.merge!({:account_id => current_user["id"], :payer_email => current_user["email"]})
    bank_details.except!(:name, :bank_account_number, :ifsc, :contact_no)
    @payee_bank_detail = PayeeBankDetail.create!(bank_details)
    
    render :nothing => true
  end

  def save_user_info

  end

  def create_roommate
    # search for email of new roommate in roommates table
      # if found, edit that record with primary_tenant as false and account_id as id of current_user.
    roommate_details = params[:roommate_details]
    roommate_details.merge!({:account_id => current_user["id"]})
    @roommate_detail = Roommate.create!(roommate_details)
    
    redirect_to(:action => 'roommate')
  end

  def create_an_issue
    # store the params in issues table. default severity should be low
    redirect_to(:action => 'issue')
  end
end
