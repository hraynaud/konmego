Rails.application.routes.draw do
  match '*path', to: 'application#preflight', via: [:options]

  get 'current_user',  to: 'application#current_user'  #FIXME is this needed?
  get 'request_token', to: 'authentication#request_token'
  get 'access_token',  to: 'authentication#access_token'

  post 'login', to: 'authentication#login'
  post 'register', to: 'registration#create'

  namespace :api do
    namespace :v1 do

      get 'people/:group', to: "people#index", constraints: {group: /contacts|endorsees|endorsers/}

      resources 'topic_contacts', only: [:index, :show], param: :topic

      resources :endorsements do
        member do 
          put :accept
          put :decline
        end
      end

      resources :projects do 
        collection do
          post :search
        end
      end
    end
  end

  root to: 'home#index'
end
