Rails.application.routes.draw do
  match '*path', to: 'application#preflight', via: [:options]

  get 'current_user',  to: 'application#current_user'  #FIXME is this needed?
  get 'request_token', to: 'authentication#request_token'
  get 'access_token',  to: 'authentication#access_token'

  post 'login', to: 'authentication#login'
  post 'register', to: 'registration#create'

  namespace :api do
    namespace :v1 do

      get 'people/:relationship_group', to: "people#index", constraints: {relationship_group: /contacts|endorsees|endorsers/}

      get 'topic_contacts/:topic', to: 'topic_contacts#index' 

      resources :contacts, only: [:index, :show]
      resources :endorsements do
        member do 
          put :accept
          put :decline
        end
      end

      resources :projects
      post 'projects/search',  to: "project_search#index"

    end
  end

  root to: 'home#index'
end
