Rails.application.routes.draw do
  # Devise routes with custom registrations controller
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }

  get "/leagues/confirmation"  => "leagues#confirmation"
  resources  :leagues
  get "/create-a-league" => "pre_leagues#new"
  resources  :pre_leagues
  resources  :teams

  # Games Index Renamed Schedule
  get "/schedule" => "games#index"
  get "games/generator_options" => "games#generator_options"
  post "games/generate" => "games#generate_games"
  delete "games/destroy_all" => "games#destroy_all"
  get "games/playoff-generator-options" => "games#playoff_options"
  post "games/generate-playoffs" => "games#generate_playoffs"
  get "games/playoff-schedule" => "games#playoff_schedule"

  resources  :games

  resources  :players
  get 'charges/confirmation' => "charges#confirmation"
  resources  :charges
  resources  :posts

  # get 'payment-setup/teams' => "dues#teams_pay"
  # get 'payment-setup/players' => "dues#players_pay"
  get 'league-pay' => "dues#league_pay"
  get 'payment-setup' => "dues#payment_setup"
  get 'payment-setup/league-dues' => "dues#league_dues"
  get 'submit-dues' => "dues#pay_dues"
  get 'pay-dues' => "dues#pay_dues"
  post  'update-dues' => "dues#update_dues"
  post 'dues-email' => "dues#dues_email"
  resources  :dues


  # get "/subscriptions/cancel_subscription"  => "subscriptions#cancel_subscription"
  # get "/subscriptions/update_card"          => "subscriptions#update_card"
  # post "/subscriptions/update_card_details" => "subscriptions#update_card_details"
  # resources  :subscriptions

  # root to: "home#index"
  root "pages#show", page: "home"

  # page after logging in from the marketing site
  get "/my-leagues" => "pages#my"

  # Pages for Marketing Site
  get "/*page" => "pages#show"

  mount StripeEvent::Engine, at: '/stripe-event' # provide a custom path
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
