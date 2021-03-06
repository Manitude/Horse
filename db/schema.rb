# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150117085959) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "contact_number"
    t.string   "pan"
    t.datetime "birth_date"
    t.string   "user_type"
    t.string   "pin_code"
    t.string   "photo_file_name"
    t.string   "gender"
    t.string   "emergency_contact"
    t.boolean  "pet",                :default => false
    t.boolean  "smoking_drinking",   :default => false
    t.string   "eating_preferences"
    t.text     "review"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "account_id",                            :null => false
    t.integer  "rating"
  end

  create_table "invite_roommates", :force => true do |t|
    t.string   "sender_email",    :null => false
    t.string   "invitee_email",   :null => false
    t.boolean  "acceptance"
    t.datetime "acceptance_date"
    t.string   "account_id",      :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "issues", :force => true do |t|
    t.datetime "reported_by"
    t.datetime "reporting_date"
    t.datetime "resolved_date"
    t.string   "status"
    t.string   "account_id",                     :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "severity",       :limit => 60
    t.string   "description",    :limit => 1000
  end

  create_table "payee_bank_details", :force => true do |t|
    t.string   "payee_email"
    t.string   "payee_name",           :null => false
    t.string   "payee_account_number", :null => false
    t.string   "payee_ifsc_code"
    t.string   "payee_contact_number"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "account_id"
  end

  create_table "payer_bank_details", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "cardholder_name"
    t.string   "card_number"
    t.string   "valid_till"
    t.string   "card_type"
    t.string   "account_id",      :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "payment_histories", :force => true do |t|
    t.string   "landlord_name"
    t.string   "property_id",                             :null => false
    t.string   "amount",                                  :null => false
    t.string   "purpose",             :default => "rent", :null => false
    t.datetime "payment_done_at"
    t.string   "payment_mode",                            :null => false
    t.datetime "payment_received_at"
    t.string   "account_id",                              :null => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.boolean  "late"
    t.boolean  "pending"
    t.boolean  "successful"
    t.string   "postal_address"
    t.string   "landlord_PAN"
  end

  create_table "properties", :force => true do |t|
    t.string   "owner_email"
    t.string   "owner_contact"
    t.string   "tenant_email"
    t.text     "description"
    t.string   "pin_code"
    t.text     "postal_address"
    t.string   "landmark"
    t.string   "area"
    t.string   "city"
    t.string   "state"
    t.string   "lease_type"
    t.integer  "rent"
    t.integer  "deposit"
    t.integer  "built_up_area"
    t.string   "furnishing"
    t.string   "water_supply_type"
    t.string   "direction_facing"
    t.integer  "bedroom"
    t.integer  "bathroom"
    t.integer  "ac"
    t.boolean  "tv"
    t.boolean  "wardrobe"
    t.boolean  "dining_table"
    t.boolean  "parking"
    t.boolean  "refrigerator"
    t.boolean  "geyser"
    t.boolean  "sofa"
    t.boolean  "gas_pipeline"
    t.boolean  "gym"
    t.boolean  "swimming_pool"
    t.boolean  "lift"
    t.boolean  "washing_machine"
    t.boolean  "microwave"
    t.string   "album_folder_name"
    t.text     "rent_agreement_terms"
    t.integer  "rent_due_date"
    t.text     "notes"
    t.text     "review"
    t.string   "account_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "rating"
  end

  create_table "reviews", :force => true do |t|
    t.text     "review"
    t.string   "rating"
    t.integer  "for_property"
    t.string   "account_id",   :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "for_account"
  end

  create_table "roommates", :force => true do |t|
    t.integer  "property_id"
    t.string   "name"
    t.string   "contact_no"
    t.string   "bank_account_number"
    t.string   "ifsc"
    t.string   "email_id"
    t.boolean  "primary_tenant"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.datetime "rent_paid_for"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
