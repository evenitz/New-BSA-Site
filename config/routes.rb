BsaWebsite::Application.routes.draw do

#match "/*glob" => 'home#work'

root :to => 'home#index'

match "/storage" => 'students#storage_redirect'
match "/sa" => 'students#card_redirect'
match "student-advantage" => 'students#card_redirect'
match "/students" => 'students#backup_redirect'
match "students/summer" => 'students#summer'
match "students/backup" => 'students#backup_software'
match "students/package" => 'students#care_packages'
match "students/card" => 'students#discount_cards'
match "students/laundry" => 'students#laundry_service'
match "students/laundry/how_it_works" => 'students#laundry_how_it_works'
match "students/linen" => 'students#linen_sales'
match "students/marketplace" => 'students#marketplace'
match "students/microfridge" => 'students#microfridge'
match "students/retail" => 'students#retailstore'
match "students/retail/past_products" => 'students#pastproducts'
match "students/storage" => 'students#storage_shipping'
match "students/storage/prepare_to_store" => 'students#preparing_to_store'
match "students/storage/storage_pricing" => 'students#storage_pricing'
match "students/storage/ship_from_brown" => 'students#ship_from_brown'
match "students/storage/ship_to_brown" => 'students#ship_to_brown'
match "students/storage/supplies" => 'students#supplies'
match "students/storage/delivery" => 'students#pickup_delivery'
match "students/planners" => 'students#student_planners'
match "students/sublet_directory" => 'students#sublet_directory'
match "students/vault" => 'students#vault'
match "students/vault/store_info" => 'students#store_info'
match "students/vault/gallery" => 'students#gallery'

match "/groups" => "groups#billboards_redirect"
match "groups/billboards" => 'groups#billboards'
match "groups/billboards/guidelines" => 'groups#slide_guidelines'
match "groups/billboards/how_to_submit" => 'groups#how_to_submit'
match "groups/ticketing" => 'groups#event_ticketing'
match "groups/marketplace" => 'groups#marketplace'
match "groups/marketplace/request_form" => 'groups#request_form'
match "groups/marketplace/transactions" => 'groups#transactions'
match "groups/posters" => 'groups#posters'
match "groups/posters/how_it_works" => 'groups#how_it_works'
match "groups/posters/policies" => 'groups#policies'

match "/biz" => 'biz#billboards_redirect'
match "biz/billboards" => 'biz#billboards'
match "biz/billboards/locations" => 'biz#locations.html.erb'
match "biz/billboards/how_it_works" => 'biz#how_it_works.html.erb'
match "biz/billboards/terms" => 'biz#terms'
match "biz/vendor_tables" => 'biz#vendor_tables'
match "biz/ticket" => 'biz#ticket_advertising.html.erb'
match "biz/planners" => 'biz#student_planners'
match "biz/request" => 'biz#request'

match '/community' => 'community#inspire_redirect'
match 'community/inspire' => 'community#inspire'
match 'community/inspire/guidelines' => 'community#guidelines'
match 'community/inspire/apply' => 'community#apply'

match 'community/events' => 'community#events'
match 'community/past_events' => 'community#past_events'
match 'community/fellowship' => 'community#fellowship'

match '/about' => 'about#history_redirect'
match 'about/history' => 'about#history'
match 'about/staff' => 'about#staff'
match 'about/contact' => 'about#contact'
match 'about/partner' => 'about#partner'
match 'about/work' => 'about#work'
match 'about/information' => 'about#information'

match '/info' => 'info#announcements_redirect'
match 'info/announcements' => 'info#announcements'
match 'info/check_in' => 'info#check_in_form'
match 'info/bsa_services' => 'info#services'
match 'info/bsa_services/billboards' => 'info#billboards'
match 'info/bsa_services/vendor_tables' => 'info#vendor_tables'
match 'info/bsa_services/marketplace' => 'info#marketplace_procedures'
match 'info/bsa_services/care_packages' => 'info#care_package'
match 'info/bsa_services/laundry' => 'info#laundry'
match 'info/procedures' => 'info#procedures'
match 'info/procedures/task_sheet' => 'info#ccis_task'
match 'info/procedures/illegal_ad' => 'info#illegal_ad'
match 'info/procedures/bsa_email' => 'info#bsa_email'
match 'info/procedures/credit_card_terminal' => 'info#credit_card_terminal'
match 'info/procedures/voicemail' => 'info#voicemail'
match 'info/procedures/payroll' => 'info#payroll'
match 'info/procedures/training_manual' => 'info#training_manual'

match 'info/documents' => 'info#documents'
match 'info/general' => 'info#general'
match 'info/general/bear_bucks' => 'info#bear_bucks'
match 'info/general/map' => 'info#maps'
match 'info/general/bulletin' => 'info#glass_bulletin'
match 'info/general/building_checklist' => 'info#building_checklist'
match 'info/general/pool_table' => 'info#pool_table'

match 'info' => 'info#index'

match 'summer' => 'summer#hours_redirect'
match 'summer/hours' => 'summer#hours'
match 'summer/fans' => 'summer#fan'
match 'summer/laundry' => 'summer#laundry'
match 'summer/microfridge' => 'summer#microfridge'
match 'summer/microfridge/order' => 'summer#order'
match 'summer/souvenirs' => 'summer#souvenirs'

match 'emails/one' => 'email_templates#email_one'
match 'emails/two' => 'email_templates#email_two'
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
