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

      get 'topic_contacts/:topic', to: 'topic_contacts#index' 
      get 'profile', to: 'users#show'

      get 'user_relationships/:group', to: "user_relationships#index", constraints: {group: /contacts|endorsees|endorsers|any/}
      post 'projects_search',  to: "project_search#index"
      post 'invites', to: "invites#create"
      get 'accept_invite', to: "invites#accept"
      put 'endorsements/accept/:endorser_id/:endorsee_id/:topic_name', to: "endorsements#accept", as: "accept_endorsement"
      put 'endorsements/decline/:endorser_id/:endorsee_id/:topic_name', to: "endorsements#decline", as: "decline_endorsement"
      put 'endorsements/destroy/:endorser_id/:endorsee_id/:topic_name', to: "endorsements#destroy", as: "destroy_endorsement"
      get 'endorsements_search',  to: "endorsement_search#index"
      
    
      resources :people
      resources :topics, only: [:index]
      resources :contacts, only: [:index, :show]
      resources :endorsements


      resources :projects do
        resources :posts do
          resources :comments
        end
      end

    end

    root to: 'home#index'
  end
end
