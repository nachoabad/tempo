Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :services, shallow: true do
      resources :events
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
end
