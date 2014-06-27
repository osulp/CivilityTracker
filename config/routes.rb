Rails.application.routes.draw do
  resources :civil_entries, :only => [:index,:update] do
    collection do
      get 'register/:serial', :to => 'civil_entries#register', :as => 'register'
    end
  end

  get 'civil_entries/qr/:serial' => Dragonfly.app.endpoint { |params, app|
    app.generate(:qr, "http://#{Rails.application.config.action_mailer.default_url_options[:host]}/civil_entries/register/#{params[:serial]}")
  }

  root :to => "home#index"
end
