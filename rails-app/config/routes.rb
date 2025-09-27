Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  match '*path', to: 'application#preflight', via: [:options]
  mount ActionCable.server => '/cable'
  get 'current_user',  to: 'application#current_user' # FIXME: is this needed?
  get 'request_token', to: 'authentication#request_token'
  get 'access_token',  to: 'authentication#access_token'

  post 'login', to: 'authentication#login'
  post 'register', to: 'registration#create'
  post 'confirm', to: 'registration#confirm'

  namespace :api do # rubocop:disable Metrics/BlockLength
    namespace :v1 do # rubocop:disable Metrics/BlockLength

      get 'profile', to: 'users#show'
      get 'user_relationships/:group', to: 'user_relationships#index',
                                       constraints: { group: /contacts|endorsees|endorsers|any/ }
      get 'accept_invite', to: 'invites#accept'
      post 'invites', to: 'invites#create'

      get 'endorsements_search', to: 'endorsement_search#index'
      get 'topic_contacts/:topic', to: 'topic_contacts#index'

      post 'projects_search',  to: 'project_search#index'
      post 'projects_random',  to: 'project_search#random'

      # AI Chat routes (existing)
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

      resources :ai_onboarding_chat, only: [:create] do
        collection do
          get :stream
        end
      end

      # Context-based chat routes
      resources :conversations, only: [:index] do
        member do
          patch :mark_as_read
        end
      end

      # Direct message conversations (user-to-user)
      get 'conversations/direct/:other_user_id', to: 'conversations#show_direct'
      post 'conversations/direct/:other_user_id', to: 'conversations#create_direct'
      post 'conversations/direct/:other_user_id/messages', to: 'messages#create_direct'

      # Project conversations
      get 'conversations/project/:project_id', to: 'conversations#show_project'
      post 'conversations/project/:project_id', to: 'conversations#create_project'
      post 'conversations/project/:project_id/messages', to: 'messages#create_project'
      patch 'conversations/project/:project_id/mark_as_read', to: 'conversations#mark_project_as_read'

      # Topic conversations
      get 'conversations/topic/:topic_id', to: 'conversations#show_topic'
      post 'conversations/topic/:topic_id', to: 'conversations#create_topic'
      post 'conversations/topic/:topic_id/messages', to: 'messages#create_topic'
      patch 'conversations/topic/:topic_id/mark_as_read', to: 'conversations#mark_topic_as_read'

      # Group conversations (still use internal ID since no natural context)
      resources :conversations, only: [] do
        resources :messages, only: %i[create update destroy] do
          member do
            patch :mark_as_read
          end
        end
      end

      # Group chat creation
      post 'conversations/group', to: 'conversations#create_group'
      get 'conversations/group/:id', to: 'conversations#show_group'
      post 'conversations/group/:id/messages', to: 'messages#create_group'

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
        resources :promotions, only: %i[create destroy], controller: 'project_promotions'
        resources :posts do
          resources :comments
        end
      end

    end

    root to: 'home#index'
  end
end
