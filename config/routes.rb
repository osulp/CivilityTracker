Rails.application.routes.draw do
  resources :civil_entries, :only => [:new, :create, :update] do
    collection do
      get 'register/:serial', :to => 'civil_entries#register', :as => 'register'
    end
  end

  root :to => "home#index"
end
