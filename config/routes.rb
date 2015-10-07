Rails.application.routes.draw do
  devise_for :users
  resources :civil_entries, :only => [:index,:update] do
    collection do
      get 'register/:serial', :to => 'civil_entries#register', :as => 'register'
    end
  end

  get "/entry/:serial", :to => 'civil_entries#register', :as => 'register'

  resources :review

  get "review_item/:id", :to => 'review#review_card', :as => 'review_card'
  get '/admin', :to => 'admin#index', :as => 'admin_index'

  get 'civil_entries/qr/:serial' => Dragonfly.app.endpoint { |params, app|
    app.generate(:qr, "http://#{Rails.application.config.action_mailer.default_url_options[:host]}/entry/#{params[:serial]}")
  }

  root :to => "home#index"
end
