Rails.application.routes.draw do
  get 'loaderio-6740bbace59df2ad01bb669b65e8333e', controller: :loader_io, action: :verify

  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'clearance/sessions', only: [:create]

  resources :users, controller: 'clearance/users', only: [:create] do
    resource :password,
             controller: 'clearance/passwords',
             only: [:create, :edit, :update]
  end

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  get '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out_get'
  get '/sign_up' => 'clearance/users#new', as: 'sign_up'

  root 'home#index'

  get '/auth/:provider/callback' => 'sessions#create_from_omniauth'

  resources :artists, only: %i(new create index)

  namespace :my, module: :current_user do
    resources :pendants, only: %i(new create index)
    resources :pendant_records, only: %i(new create index)
    resources :fake_pendant_records, only: %i(new create)
    resources :artists, only: %i(index)

    resources :crews, only: %i(new create index) do
      resources :crew_memberships, only: %i(new create index)
    end

    resource :last_week_in_pendants, only: %i(show)
  end

  namespace :api do
    namespace :my, module: :current_user do
      resources :push_notification_subscriptions, only: %i(create)
    end
  end
end
