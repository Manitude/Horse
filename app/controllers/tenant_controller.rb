class TenantController < ApplicationController
  before_filter :authenticate_user!
	layout 'tenant'
  
  def index
    # payee_bank_detail = PayeeBankDetail.where(["account_id = ?", current_user.id]).last
    # if payee_bank_detail
    #   rent_information = get_rent_info
    #   @host_id = check_roommate_invitation.sender_email if check_roommate_invitation
    #   @data = {:rent_amount => rent_information[:rent_amount], :rent_due_date => rent_information[:rent_due_date], :color_class_code => rent_information[:color_class_code]}
    # end
    # render :layout => 'application', :template => 'register_tenant/landlord_bank_detail.html.erb' if !payee_bank_detail
    rm_invite, pbd_details, rent_details, my_rm_group, sender_rm_group, my_rm_count, sender_rm_count = check_roommate_invitation
    @host = {
              :id => rm_invite,
              :landlord_name => pbd_details.payee_name,
              :landlord_ac_no => pbd_details.payee_account_number,
              :landlord_ifsc => pbd_details.payee_ifsc_code,
              :rent => rent_details.rent,
              :my_group_share => rent_details.rent.fdiv(my_rm_count.to_i + sender_rm_count.to_i).ceil,
              :my_solo_share => rent_details.rent.fdiv(sender_rm_count.to_i + 1).ceil,
              :my_rm_list => my_rm_group,
              :sender_rm_list => sender_rm_group,
              :payment_date => rent_details.rent_due_date
    } if rm_invite
    if registered_user
      property = Property.where(["id = ?", registered_user.property_id]).first
      landlord_detail = PayeeBankDetail.fetch_details(current_user.email).first
      rent_information = get_rent_info(property)
      @data = {:rent_amount => rent_information[:rent_amount], :rent_due_date => rent_information[:rent_due_date], :color_class_code => rent_information[:color_class_code], :landlord_name =>landlord_detail.payee_name, :landlord_ac_no => landlord_detail.payee_account_number, :landlord_ifsc => landlord_detail.payee_ifsc_code}
    end
  end

  def make_payment
    initiate_payment(params[:payment_details][:rent_amount],params[:payment_details][:rent_due_date])
    redirect_to(:action => 'payment_history')
  end

  def register_user
    all_details = params[:bank_and_payment_details]
    account_details = {:account_id => "T"<<current_user["id"].to_s, :email => current_user["email"], :name => all_details["payer_name"], :contact_number => all_details["payer_contact"], :user_type => 'Tenant'}
    landlord_details = {:account_id => "L"<<current_user["id"].to_s, :name => all_details["payee_name"], :contact_number => all_details["payee_contact"], :user_type => 'Landlord'}
    Account.transaction do
      Account.create!(account_details)
      landlord = Account.create!(landlord_details)
      property_details = {
      :account_id => landlord.account_id, 
      :owner_contact => all_details["payee_contact"],
      :tenant_email => current_user["email"], 
      :rent => all_details["rent_amount"], 
      :deposit => all_details["security_deposit"], 
      :rent_due_date => all_details["rent_due_date"]
      }
      property = Property.create!(property_details)
      bank_details = {
      :account_id => landlord.account_id,
      :payee_name => all_details["payee_name"], 
      :payee_account_number => all_details["payee_account_number"], 
      :payee_ifsc_code => all_details["payee_ifsc_code"],
      :payee_contact_number => all_details["payee_contact"]
      }
      PayeeBankDetail.create!(bank_details)
      roommate_details = {
        :property_id => property.id, 
        :email_id => current_user["email"],
        :name => all_details["payer_name"],
        :contact_no => all_details["payer_contact"],
        :primary_tenant => false
      }
      Roommate.create!(roommate_details)
    end
    # initiate_payment(all_details[:rent_amount],Time.now.at_beginning_of_month + (all_details[:rent_due_date].to_i - 1).day)
  redirect_to(:action => 'index')
  end

  def register_tenant
    render :layout => 'application', :template => 'register_tenant/landlord_bank_detail.html.erb'
  end

  def user_profile
    account_detail = Account.find_by_email(current_user.email)
    rm_detail = Roommate.find_by_email_id(current_user.email)
    @data = {
      :name => account_detail.name,
      :email => account_detail.email,
      :contact_number => account_detail.contact_number,
      :bank_account_number => rm_detail.bank_account_number,
      :ifsc => rm_detail.ifsc
    } if registered_user
  end

  def property_profile
    @data = Property.fetch_property_details(current_user.email) if registered_user
  end

  def bank_details
    @data = PayeeBankDetail.fetch_details(current_user.email).first if registered_user
  end

  #This method is called, once we get a confirmation from PG(might be shifted to a rake task later)
  def update_payment_history
    success = true
    # property = Property.where(["account_id = ?", Account.find_by_email(current_user.email).account_id]).last
    # TODO: make a call to PG
    payment_history_details = {
      :payment_received_at => Time.now, #need to update this value once we get info from PG
      :pending => 0, #need to update this value once we get info from PG
      :successful => suceess ? 1 : 0, #need to update this value once we get info from PG
    }
    property.update_attributes(payment_history_details)
  end

  def payment_history
  #  payment_data = PaymentHistory.where(["account_id = ?", current_user.id])
    #@payment_data = payment_data.to_json
  # @payment_data = "[{\"account_id\":15,\"payee_account_number\":\"xyz1234\",\"payee_email\":\"rajamani@landlord.com\"}]"
  #  "[{\"account_id\":15,\"created_at\":\"2014-11-24T14:36:30Z\",\"id\":11,\"payee_account_number\":\"xyz1234\",\"payee_contact_number\":1234567890,\"payee_email\":\"rajamani@landlord.com\",\"payee_ifsc_code\":\"ICICI007\",\"payee_name\":\"raja mani\",\"updated_at\":\"2014-11-24T14:36:30Z\"},{\"account_id\":15,\"created_at\":\"2014-11-24T14:36:48Z\",\"id\":12,\"payee_account_number\":\"xyz1234\",\"payee_contact_number\":1234567890,\"payee_email\":\"rajamani@landlord.com\",\"payee_ifsc_code\":\"ICICI007\",\"payee_name\":\"raja mani\",\"updated_at\":\"2014-11-24T14:36:48Z\"}]"

  #  [#<PayeeBankDetail id: 11, payee_email: "rajamani@landlord.com", payee_name: "raja mani", payee_account_number: "xyz1234", payee_ifsc_code: "ICICI007", payee_contact_number: 1234567890, account_id: 15, created_at: "2014-11-24 14:36:30", updated_at: "2014-11-24 14:36:30">, 
  #  #<PayeeBankDetail id: 12, payee_email: "rajamani@landlord.com", payee_name: "raja mani", payee_account_number: "xyz1234", payee_ifsc_code: "ICICI007", payee_contact_number: 1234567890, account_id: 15, created_at: "2014-11-24 14:36:48", updated_at: "2014-11-24 14:36:48">]
  end

  # fetches all records present in payment history table for the current_user.
  def ph_data
    payment_data = PaymentHistory.where(["account_id = ?", Account.find_by_email(current_user.email).account_id])
    render :json => payment_data.to_json
  end

  def save_landlord_bank_info
    bank_details = params[:bank_details]
    payeeBankDetail = PayeeBankDetail.find_by_account_id(find_landlord_info.account_id)
    payeeBankDetail.update_attributes(bank_details)      
    redirect_to(:action => 'bank_details')
  end

  def save_user_info
  # Saves the user info into the account table, with user type as Tenant.
    all_details = params[:user_detail]
    user_details = {:name => all_details["name"], :contact_number => all_details["contact_number"]}
    roommate_details = {:bank_account_number => all_details["bank_account_number"], :ifsc => all_details["ifsc"]}
    user = Account.find_by_email(current_user.email)
    rm = Roommate.find_by_email_id(current_user.email)
    ActiveRecord::Base.transaction do
      user.update_attributes!(user_details)
      rm.update_attributes!(roommate_details)
    end
    redirect_to(:action => 'user_profile')
  end

  def save_property_details
    all_details = params[:property]
    property_details = 
    {
      :description => all_details["description"],
      :area => all_details["area"],
      :pin_code => all_details["pin_code"],
      :postal_address => all_details["postal_address"] + all_details["postal_address_2"],
      :landmark => all_details["landmark"],
      :city => all_details["city"],
      :state => all_details["state"],
      :built_up_area => all_details["built_up_area"],
      :lease_type => all_details["lease_type"],
      :water_supply_type => all_details["water_supply_type"],
      :direction_facing => all_details["direction_facing"],
      :furnishing => all_details["furnishing"],

      :bedroom => all_details["bedroom"],
      :bathroom => all_details["bathroom"],
      :wardrobe => all_details["wardrobe"],
      :ac => all_details["ac"],
      :tv => all_details["tv"],
      :dining_table => all_details["dining_table"],
      :parking => all_details["parking"],
      :refrigerator => all_details["refrigerator"],
      :geyser => all_details["geyser"],
      :sofa => all_details["sofa"],
      :gas_pipeline => all_details["gas_pipeline"],
      :gym => all_details["gym"],
      :swimming_pool => all_details["swimming_pool"],
      :lift => all_details["lift"],
      :washing_machine => all_details["washing_machine"],
      :microwave => all_details["microwave"]
    }
    property = Property.where(["account_id = ?", Account.find_by_email(current_user.email).account_id]).last
    property.update_attributes(property_details)

    redirect_to(:action => 'index')
  end

  # will not be used
  # def pay_rent #not verified
  # # gets triggered when user clicks pay now button.
  # # create a new row in PaymentHistory 
  #   payment_done_at = Time.now
  #   payment_details = params[:payment_details]
  #   landlord_name = PayeeBankDetail.where(:id => current_user["id"]).pluck(:payee_name)
  #   payment_history_detail = 
  #   {
  #     :payment_done_at => payment_done_at, 
  #     :account_id => current_user["id"], 
  #     :tenant_email => current_user["email"], 
  #     :late => payment_done_at - payment_details["payment_due_date"] == 1 ? true : false, 
  #     :pending => true, 
  #     :successful => false, 
  #     :landlord_email => landlord_name, 
  #     :status =>"Pending"
  #   }
  #   @payment_detail = PaymentHistory.create!(payment_details)

  #   roommate = Roommate.where(["email_id = ?", current_user["email"]]).last
  #   roommate.update_attribute(:rent_paid_for => Time.now)
  # end

  # finds list of all roommates added by the primary tenant
  def rent_receipt
    payment_history = PaymentHistory.where(["account_id = ?", Account.find_by_email(current_user.email).account_id]) if registered_user
    if payment_history and !payment_history.empty?
      paid_first_at = payment_history.first.payment_done_at
      from_year = (paid_first_at.month < 4) ? paid_first_at.year - 1 : paid_first_at.year
      till_year = (Time.now.month < 4) ? Time.now.year : Time.now.year + 1
      valid_time_period = []
      for i in 1..(till_year - from_year)
        valid_time_period << "April, #{from_year+i-1} to March, #{from_year+i}"
      end
      payment_details = []
      payment_history.each do |data|
        detail = {:receipt_no => data.id, :amount => data.amount, :landlord_name => data.landlord_name, :payment_date => data.payment_done_at, :property_address => data.postal_address, :landlord_pan => data.landlord_PAN}
        payment_details << detail
      end
      @data = {
        :payment_details => payment_details,
        :valid_time_period => valid_time_period 
      } 
    end
  end

  # finds list of all details for roommates added by the primary tenant
  def roommate_data
    roommate_data = Roommate.fetch_roommates(current_user["email"])
    render :json => roommate_data.to_json
  end

  def create_roommate
  # search for email of new roommate in roommates table
    # if found, edit that record with primary_tenant as false and account_id as id of current_user.
    roommate_details = params[:roommate_details]
    roommate_details.merge!({:property_id => current_user["id"]})
    @roommate_detail = Roommate.create!(roommate_details)
    
    redirect_to(:action => 'roommate')
  end

  def search_roommate
    if params["email_id"] == current_user["email"]
        roommate_info = 'invalid_id'
    elsif Roommate.find_by_email_id(current_user["email"])
      if Roommate.find_by_email_id(params["email_id"])
        Roommate.fetch_roommates(current_user["email"]).each do |data|
          if data.email_id == params["email_id"]
            roommate_info = 'already_roommates'
          end
        end
        unless roommate_info
          roommate_info = 'request_sent' 
          invite_roommate(params["email_id"])
        end
      else
        roommate_info = 'invitation_sent'
        # trigger an email to send an invite to the mail_id received
        invite_roommate(params["email_id"])
      end
    else
      roommate_info = 'no_information'
    end
    render :text => roommate_info

    # if Roommate.find_by_email_id(current_user["email"])
    #   if params["email_id"] == current_user["email"]
    #     roommate_info = 'invalid_id'
    #   elsif Roommate.find_by_email_id(params["email_id"])
    #     roommate_info = nil
    #     Roommate.fetch_roommates(current_user["email"]).each do |data|
    #       if data.email_id == params["email_id"]
    #         roommate_info = 'already_roommates'
    #       end
    #     end
    #     unless roommate_info
    #       roommate_info = 'request_sent' 
    #       invite_roommate(params["email_id"])
    #     end
    #   elsif User.find_by_email(params["email_id"])
      
    #   end
    # else
    #   roommate_info = 'invitation_sent'
    #   # trigger an email to send an invite to the mail_id received
    #   invite_roommate(params["email_id"])
    # end
    # end
    
  end

  def roommate_request_response
    #invitation_record, pt_landlord, pt_property = check_roommate_invitation
    #invitation_record = InviteRoommate.where(['invitee_email = ? AND sender_email = ? AND acceptance IS NULL', current_user["email"], Account.find_by_account_id(pt_landlord.first.account_id).email]).first
    invitation_record = InviteRoommate.where(['invitee_email = ? AND acceptance IS NULL', current_user["email"]]).first
    if params["response"] and params["response"] != 'roommate_denied'
      rm_detail = Roommate.find_by_email_id(params["host_id"])
      InviteRoommate.transaction do
        if params["response"] == 'roommate_accepted' || params["response"] == 'solo_accepted'
          my_detail = Roommate.find_by_email_id(current_user.email)
          delete_redundant_record(rm_detail.property_id, my_detail.property_id)
          my_detail.update_attributes(:property_id => rm_detail.property_id)
        elsif params["response"] == 'group_accepted'
          my_rm_detail = Roommate.fetch_roommates(current_user.email)
          my_rm_detail.each{|rm| 
            delete_redundant_record(rm_detail.property_id, rm.property_id)
            rm.update_attributes(:property_id => rm_detail.property_id)
          }
        end
        rm_detail.update_attributes(:primary_tenant => true)


      # update Payee_bank_detail
      #  rm_data = PayeeBankDetail.find_by_account_id(invitation_record["account_id"])
        # my_payee_detail = PayeeBankDetail.find_by_account_id(current_user.id)
        # my_payee_detail.update_attributes(:payee_email => pt_landlord.first.payee_email, :payee_name => pt_landlord.first.payee_name, :payee_account_number => pt_landlord.first.payee_account_number, :payee_ifsc_code => pt_landlord.first.payee_ifsc_code, :payee_contact_number => pt_landlord.first.payee_contact_number)
        # update property_id in Roommate of the current user and set primary tenant as 0 for current_user  
        # rm_detail = Roommate.find_by_email_id(current_user["email"])
        # rm_detail.update_attributes(:property_id => pt_property.first.id, :primary_tenant => false)
        # tenant_list = Roommate.fetch_roommates(invitation_record.sender_email)
        
        # rm.update_rm_detail!(Property.get_property_id(invitation_record.sender_email))
        # tenant_list.first.set_as_primary_tenant! if tenant_list.first.primary_tenant == false
        # # update rent amount for all other roommates
        # payment_date = Property.find_by_tenant_email(tenant_list.first.email_id).rent_due_date
        # updated_rent = (Property.find_by_tenant_email(tenant_list.first.email_id).rent * tenant_list.size).fdiv(tenant_list.size + 1).ceil
        # tenant_list. each do |data|
        #   Property.find_by_tenant_email(data.email_id).update_attributes(:rent => updated_rent, :rent_due_date => payment_date)
        # end
      end
      # update invite_roommate
        invitation_record.update_invitation(true)
    else
      invitation_record.update_invitation(false)
    end
    render :text => 'true'
  end

  def edit_roommate_details
    # list down all the information from roommates.rb model and present them in a tabular column.
  end
  
  def delete_roommate_details
    # list down all the information from roommates.rb model and present them in a tabular column.
  end

  def save_user_profile
    
  # Saves the user info into the account table, with user type as Tenant.

  # Not sure how to save profile pic.
    render :layout => 'application', :template => 'register_tenant/landlord_bank_detail.html.erb'
  end

  def save_property_profile
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

  

  def issue
  # Fetches two lists of issue from issue table, and render a view displaying both.
    @issue_list = Issue.find(:all)
  #if any of the rows are edited, then save the updated rows in the db and return the same view with success msg.
  end

  def report_issue
  # Creates a new issue and saves it to the db. A success msg is displayed in case of a successful save.
  end
  
  def payee_detail
  # Saves the payee bank details into the payee_bank_detail table.
  end

  def property_detail
  # Saves the property details into the payee_bank_detail table.
  end

  def create_an_issue
  # store the params in issues table. default severity should be low
    redirect_to(:action => 'issue')
  end

  def submit_review
    property = Property.where(["account_id = ?", Account.find_by_email(current_user.email).account_id]).last
    if property.update_attributes(:rating => params[:rating], :review => params[:review])
      render :text => 'success'
    else
      render :text => 'failure'
    end
  end

  private

  def get_rent_info(property)
    rent_amount = property["rent"]
    rent_date = property["rent_due_date"]
    rent_due_date = Time.now.at_beginning_of_month + (rent_date - 1).day
    color_class_code = '#777777'

    payment_history = PaymentHistory.where(["account_id = ?", Account.find_by_email(current_user.email).account_id])
    if !payment_history.empty? and (payment_history.last["payment_done_at"].month == Time.now.month) #&& payment_history["payment_received_at"] 
      rent_due_date = Time.now.at_beginning_of_month.next_month + (rent_date - 1).day
    else
      color_class_code = '#7266BA' if rent_due_date == Time.now
      color_class_code = '#B84D45' if rent_due_date < Time.now
    end
    rent_info ={
      :rent_amount => calculate_rent(rent_amount, property["id"]),
      :rent_due_date => rent_due_date.to_date,
      :color_class_code => color_class_code
    }
    return rent_info
  end

  def calculate_rent(total_amount, property_id)
    rent_amount = (total_amount.fdiv(Roommate.find_all_by_property_id(property_id).size)).ceil
  end

  def invite_roommate(email_id)
    InviteRoommate.create!({:account_id => current_user["id"], :sender_email => current_user["email"], :invitee_email => email_id})
  end

  def check_roommate_invitation
    rm_flag = InviteRoommate.where(['invitee_email = ? AND acceptance IS NULL', current_user["email"]]).first
    # check for landlord details of sender and current_user, if not same send another parameter with the diff values
    if rm_flag
      pbd_flag = PayeeBankDetail.fetch_details(rm_flag.sender_email).first
      rent_flag = Property.where(['id = ?', Roommate.find_by_email_id(rm_flag.sender_email).property_id]).first
      my_rm_list, my_rm_count = fetch_rm_list(current_user["email"], true)
      sender_rm_list, sender_rm_count = fetch_rm_list(rm_flag.sender_email, false)
    end
    return rm_flag ? rm_flag.sender_email : nil, pbd_flag, rent_flag, my_rm_list, sender_rm_list, my_rm_count, sender_rm_count
  end

  def fetch_rm_list(email_id, self_flag = false)
    rm_list = []
    roommates = Roommate.fetch_roommates(email_id)
    count = 0
    roommates.each{|rm| 
      rm_list << "#{rm.name}(#{rm.email_id})"
      count += 1
    }
    if rm_list.length == 1 and !self_flag
      return "#{rm_list.first}", 1
    elsif rm_list.length == 1 and self_flag
      return nil, 1
    end
    return "#{rm_list[0..-2].join(", ")} and #{rm_list.last}", count
  end

  def initiate_payment(rent,payment_date, purpose = 'rent')
    due_date = payment_date.to_time
    property = Property.fetch_property_details(current_user.email)
    landlord = find_landlord_info
    payment_history_details = {
      :landlord_name => landlord.name,
      :property_id => property["id"],
      :amount => rent,
      :purpose => purpose,
      :payment_done_at => Time.now,
      :payment_mode => 'Credit Card', #need to get this info from PG vendor
      :payment_received_at => 'Pending', #need to update this value once we get info from PG
      :account_id => Account.find_by_email(current_user.email).account_id,
      :late => due_date.to_date < Time.now.to_date ? 1 : 0,
      :pending => 1, #need to update this value once we get info from PG
      :successful => 0, #need to update this value once we get info from PG
      :postal_address => property.postal_address,
      :landlord_PAN => landlord.pan
    }
    PaymentHistory.transaction do
      # TODO: make a call to PG
      PaymentHistory.create!(payment_history_details)
      roommate = Roommate.find_by_email_id(current_user["email"])
      roommate.update_attributes(:rent_paid_for => Time.now)
    end
  end

  def delete_redundant_record(host_property_id, user_property_id)
    if host_property_id !=  user_property_id
      my_property_detail = Property.find_by_id(user_property_id)
      host_property_detail = Property.find_by_id(host_property_id)
      # compare rent and landlord_account_no before deleting
      if host_property_detail.rent == my_property_detail.rent && PayeeBankDetail.find_by_account_id(host_property_detail.account_id).payee_account_number == PayeeBankDetail.find_by_account_id(host_property_detail.account_id).payee_account_number
        Account.delete(Account.find_by_account_id(my_property_detail.account_id).id)
        PayeeBankDetail.delete(PayeeBankDetail.find_by_account_id(my_property_detail.account_id).id)
        Property.delete(user_property_id)
      else
        my_property_detail.update_attributes(:tenant_email => nil)
      end
    end
  end

  def registered_user
    Roommate.find_by_email_id(current_user.email)
  end

  def find_landlord_info
    Account.find_by_account_id(Property.find_by_id(Roommate.find_by_email_id(current_user.email).property_id).account_id)    
  end

end