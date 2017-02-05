# frozen_string_literal: true
Rails.application.routes.draw do
  get 'loaderio-6740bbace59df2ad01bb669b65e8333e', controller: :loader_io, action: :verify

  resources :passwords, controller: 'clearance/passwords', only: %i(new create)
  resource :session, controller: 'clearance/sessions', only: %i(create) do
    resource :u2f, controller: 'u2f_sessions', only: %i(new create)
  end

  resources :users, controller: 'clearance/users', only: %i(create) do
    resource :password,
             controller: 'clearance/passwords',
             only: %i(create edit update)
  end

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  get '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out_get'
  get '/sign_up' => 'clearance/users#new', as: 'sign_up'

  root 'home#index'

  get '/auth/:provider/callback' => 'sessions#create_from_omniauth'

  resources :artists, only: %i(new create index)
  resources :collections, only: %i(show edit update new create) do
    resources :pendants, only: %i(show)
  end

  namespace :my, module: :current_user do
    resources :pendants, only: %i(new create index show edit update)
    resources :pendant_records, only: %i(new create index)
    resources :fake_pendant_records, only: %i(new create)
    resources :artists, only: %i(index)

    resource :last_week_in_pendants, only: %i(show)

    resources :u2f_registrations, only: %i(new create)

    resource :settings, only: %i(show)
  end

  namespace :api do
    namespace :my, module: :current_user do
      resources :push_notification_subscriptions, only: %i(create)
    end
  end
end
