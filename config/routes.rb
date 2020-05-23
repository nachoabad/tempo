Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  devise_scope :admin do
    get "admins/auth/admin_google/callback"  => "admins/omniauth_callbacks#admin_google"
  end

  devise_scope :user do
    get "users/auth/user_google/callback"  => "users/omniauth_callbacks#user_google"
  end

  get '/privacidad', to: 'pages#privacy'

  namespace :admin do
    resources :services, shallow: true do
      resources :events
      resources :slots
      resources :blockers do
        collection do
          post 'block'
          post 'unblock'
        end
      end
    end

    root to: 'services#index'
  end

  resources :services, shallow: true do
    resources :slots do
      resources :events, only: [:new, :create]
    end
  end
  resources :events, only: [:index, :destroy]
  get '/:slug', to: 'slots#index'

  resources :pages,  only: :index
  resources :free_trials, only: [:new, :create]

  root to: 'pages#index'
end
