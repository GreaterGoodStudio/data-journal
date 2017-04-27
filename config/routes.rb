Rails.application.routes.draw do
  root to: "projects#index"

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  # ActionCable
  mount ActionCable.server => "/cable"

  # Auth
  devise_for :users, skip: [:registrations, :sessions]
  as :user do
    get "users/edit" => "devise/registrations#edit", :as => "edit_user_registration"
    put "users" => "devise/registrations#update", :as => "user_registration"
    get "signin", to: "devise/sessions#new", as: :new_user_session
    post "signin", to: "devise/sessions#create", as: :user_session
    delete "signout", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  # Resources
  resources :projects, shallow: true do
    member do
      post "archive"
      post "unarchive"
    end

    resources :membership, only: [:destroy] do
      member do
        post "promote"
        post "demote"
        post "reinvite"
      end
    end

    resources :sessions do
      get "upload", on: :member, as: :upload_asset_to

      resources :data_points, except: [:index] do
        member do
          post "bookmark"
          post "unbookmark"
        end
      end

      resources :consent_forms, only: [:show, :create]
      resources :photos, only: [:index, :show, :destroy]
    end
  end
end