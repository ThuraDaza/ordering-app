Rails.application.routes.draw do
  root "waiter_login#index"

  resources :chefs
  resources :waiters
  resources :items
  resources :order_items

  get "chef_login", to: "chef_login#index"
  post "chef_sign_in", to: "chef_login#sign_in"
  post "chef_sign_out", to: "chef_login#sign_out"
  get "waiter_login", to: "waiter_login#index"
  post "waiter_sign_in", to: "waiter_login#sign_in"
  post "waiter_sign_out", to: "waiter_login#sign_out"
  get "graph", to: "chefs#graph"

  get "chef_forget_password", to: "chef_password_resets#index"
  post "chef_forget_password", to: "chef_password_resets#create"
  get "chef_password_reset_edit", to: "chef_password_resets#edit"
  patch "chef_password_reset_edit", to: "chef_password_resets#update"

  get "waiter_forget_password", to: "waiter_password_reset#index"
  post "waiter_forget_password", to: "waiter_password_reset#create"
  get "waiter_password_reset_edit", to: "waiter_password_reset#edit"
  patch "waiter_password_reset_edit", to: "waiter_password_reset#update"

  get "password", to: "chefs#change_password"
  post "password", to: "chefs#update_password"

  get "waiter_password", to: "waiters#waiter_change_password"
  post "waiter_password", to: "waiters#waiter_update_password"

  #waiter order process
  post "select", to: "waiters#select_item"
  post "cancel", to: "waiters#cancel_item"
  post "confirm", to: "waiters#confirm_order"
  get "orders", to: "waiters#get_orders"
  get "order", to: "waiters#show_order"
  post "pick_order", to: "waiters#pick_order"

  #chef order process
  post "processing", to: "order_items#processing_item"
  post "finished", to: "order_items#finish"
end
