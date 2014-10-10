Horse::Application.routes.draw do

  devise_for :users
  devise_for :users do
    get 'logout' => 'devise/sessions#destroy'
  end

  get "landlord/index"

  get "tenant/index"

  get "home/index"

  root :to => "home#index"
  match 'tenant' => 'tenant#index', :as => :tenant
  match 'landlord' => 'landlord#index', :as => :landlord

  match 'tenant/pay_now' => 'tenant#index', :as => :tenant_pay_now
  match 'tenant/dashboard' => 'tenant#dashboard', :as => :tenant_dashboard
  match 'tenant/roommate' => 'tenant#roommate', :as => :tenant_roommate
  match 'tenant/payment_history' => 'tenant#payment_history', :as => :tenant_payment_history
  match 'tenant/issue' => 'tenant#issue', :as => :tenant_issue
  match 'tenant/user_profile' => 'tenant#user_profile', :as => :tenant_user_profile
  match 'tenant/property_profile' => 'tenant#property_profile', :as => :tenant_property_profile
  match 'tenant/bank_details' => 'tenant#bank_details', :as => :tenant_bank_details
  match 'tenant/setting' => 'tenant#setting', :as => :tenant_setting

  match 'tenant/save_property_details' => 'tenant#save_property_details', :as => :save_property_details
  match 'tenant/pay_rent_credit' => 'tenant#pay_rent_through_credit', :as => :pay_rent_through_credit
  match 'tenant/pay_rent_debit' => 'tenant#pay_rent_through_debit', :as => :pay_rent_through_debit
  match 'tenant/save_user_info' => 'tenant#save_user_info', :as => :save_user_info
  match 'tenant/create_roommate' => 'tenant#create_roommate', :as => :create_roommate
  match 'tenant/create_an_issue' => 'tenant#create_an_issue', :as => :create_an_issue

  match 'landlord/dashboard' => 'landlord#index', :as => :landlord_dashboard
  match 'landlord/payment_history' => 'landlord#payment_history', :as => :landlord_payment_history
  match 'landlord/issue' => 'landlord#issue', :as => :landlord_issue
  match 'landlord/profile' => 'landlord#profile', :as => :landlord_profile
  match 'landlord/return_deposit' => 'landlord#return_deposit', :as => :landlord_return_deposit
  match 'landlord/list_property' => 'landlord#list_property', :as => :list_a_property
  match 'landlord/setting' => 'landlord#setting', :as => :landlord_setting
  
  match 'tenant/save_landlord_bank_info' => 'tenant#save_landlord_bank_info', :as => :save_landlord_bank_info
  match 'tenant/save_user_info' => 'tenant#save_user_info', :as => :save_user_info


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
