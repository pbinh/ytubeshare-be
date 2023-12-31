Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  mount ActionCable.server => "/cable"

  namespace :api, defaults: { format: :json } do
    #---Users
    post 'register', to: 'users#create'
    #---Authen
    post 'login', to: 'jwt#login'
    #---Videos
    get 'videos', to: 'videos#list'
    post 'videos', to: 'videos#add_video'
    get 'test', to: 'videos#test_notify'
  end
  # Defines the root path route ("/")
  # root "posts#index"
end
