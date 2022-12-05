Rails.application.routes.draw do
  match '*path', to: 'application#preflight', via: [:options]

  get 'current_user',  to: 'application#current_user'  #FIXME is this needed?
  get 'request_token', to: 'authentication#request_token'
  get 'access_token',  to: 'authentication#access_token'

  post 'login', to: 'authentication#login'
  post 'register', to: 'registration#create'
  post 'confirm', to: 'registration#confirm'

  namespace :api do
    namespace :v1 do

      post 'invite', to: 'invites#create'

      get 'people/:relationship_group', to: "people#index", constraints: {relationship_group: /contacts|endorsees|endorsers|any/}

      get 'topic_contacts/:topic', to: 'topic_contacts#index' 
      post 'projects_search',  to: "project_search#index"

      resources :topics, only: [:index]
      resources :contacts, only: [:index, :show]
      resources :endorsements do
        member do 
          put :accept
          put :decline
        end
      end

      resources :projects do
        resources :posts do
          resources :comments
        end
      end
     
    end

    root to: 'home#index'
  end
end
