Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  match '*path', to: 'application#preflight', via: [:options]

  get 'current_user',  to: 'application#current_user' # FIXME: is this needed?
  get 'request_token', to: 'authentication#request_token'
  get 'access_token',  to: 'authentication#access_token'

  post 'login', to: 'authentication#login'
  post 'register', to: 'registration#create'
  post 'confirm', to: 'registration#confirm'

  namespace :api do # rubocop:disable Metrics/BlockLength
    namespace :v1 do

      get 'profile', to: 'users#show'
      get 'user_relationships/:group', to: 'user_relationships#index',
                                       constraints: { group: /contacts|endorsees|endorsers|any/ }
      get 'accept_invite', to: 'invites#accept'
      post 'invites', to: 'invites#create'

      get 'endorsements_search', to: 'endorsement_search#index'
      get 'topic_contacts/:topic', to: 'topic_contacts#index'

      post 'projects_search',  to: 'project_search#index'
      post 'projects_random',  to: 'project_search#random'

      resources :chat, only: [:create] do
        collection do
          get :stream
        end
      end

      resources :ai_project_chat, only: [:create] do
        collection do
          get :stream
        end
      end

      resources :people
      resources :topics, only: [:index]
      resources :contacts, only: %i[index show]
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
