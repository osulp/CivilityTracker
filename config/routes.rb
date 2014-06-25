Rails.application.routes.draw do
  resources :civil_entries, :only => [:new, :create, :update]

  root :to => "home#index"
end
