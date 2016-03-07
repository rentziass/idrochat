Rails.application.routes.draw do
  devise_for :users
  root "rooms#general"
  get "/", to: "rooms#general"

  resources :rooms, only: [:show] do
    collection do
      get "manager", to: "rooms#manager", as: "manager"
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        collection do
          get "search", to: "users#search"
        end
      end
    end
  end

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
