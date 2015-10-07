Rails.application.routes.draw do
  devise_for :users
  resources :civil_entries, :path => "entry/", :only => [:index,:update] do
    collection do
      get ':serial', :to => 'civil_entries#register', :as => 'register'
    end
  end

  resources :review

  get "review_item/:id", :to => 'review#review_card', :as => 'review_card'
  get '/admin', :to => 'admin#index', :as => 'admin_index'

  get 'entry/qr/:serial' => Dragonfly.app.endpoint { |params, app|
    app.generate(:qr, "http://#{Rails.application.config.action_mailer.default_url_options[:host]}/entry/#{params[:serial]}")
  }

  root :to => "home#index"
end
