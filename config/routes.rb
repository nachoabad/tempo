Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  namespace :admin do
    resources :services, shallow: true do
      resources :slots, :events
    end
    root to: 'services#index'
  end

  resources :services, shallow: true do
    resources :slots
    resources :events
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
