Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products, :wishlists, :addresses, :product_reviews
  
  resources :orders do
    get :show_cart, on: :collection
  end

  namespace :api do 
    resources :products
  end

  root 'products#index'
  get 'about_us_users', to: 'products#about', as: 'about_us_users'
  get '/search', to: 'products#search'
  put 'update_total_price', to: 'orders#update_product_quantity', as: 'update_total_price'
  get 'destroy_productsorder', to: 'orders#remove_product_from_cart'
  get 'destroy_product_wishlist', to: 'wishlists#remove_product_from_wishlist'
  get 'add_wishlist', to: 'wishlists#add'
  post 'payment',to: 'payments#create'
  post 'verify/:id',to: 'payments#verify'
  get 'placedorders',to: 'orders#show_my_orders'
  get 'order_details',to:'orders#order_details'
  get 'user_profile_edit',to:'users#profile_edit'
  get 'show_address',to:'addresses#show_address'
  get 'add_shipping_address',to:'orders#add_shipping_address'
  get 'payment_method', to:'orders#payment_method'
  get 'update_payment_method', to: 'orders#update_payment_method_as_COD'
  get 'cancel_order', to: 'orders#cancel_order'
  post 'notify_me' ,to:'products#create_product_notify'
  get  'show_wishlist' ,to:'wishlists#show_wishlist'
  post 'product_review' ,to:'products#create_product_review'
end

