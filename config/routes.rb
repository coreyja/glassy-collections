Rails.application.routes.draw do
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

  resources :nails, only: %i(new create index destroy)

  resources :dabs, only: %i(new create index)

  resources :artists, only: %i(new create index)

  namespace :user, module: :current_user do
    resources :pendants, only: %i(new create index)
    resources :pendant_records, only: %i(new create index)

    resources :crews, only: %i(new create index) do
      resources :crew_memberships, only: %i(new create index)
    end

    resource :last_week_in_pendants, only: %i(show)
  end
end
