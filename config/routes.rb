Rails.application.routes.draw do
  match '*path', to: 'application#preflight', via: [:options]

  get 'current_user',  to: 'application#current_user'
  get 'request_token', to: 'authentication#request_token'
  get 'access_token',  to: 'authentication#access_token'

  post 'login', to: 'authentication#login'

  namespace :api do
    namespace :v1 do
      resources 'topic_contacts', only: [:index, :show], param: :topic
    end
  end

  match '/*path', to: 'application#index', via: [:get]
end
