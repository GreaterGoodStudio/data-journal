require "sidekiq/web"

Rails.application.routes.draw do
  root to: "projects#index"

  # Sidekiq
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  # ActionCable
  mount ActionCable.server => "/cable"

  # Auth
  devise_for :users, controllers: { invitations: "users/invitations" }, skip: [:registrations, :sessions]
  as :user do
    get "users/edit" => "users/registrations#edit", :as => "edit_user_registration"
    get "users/edit_avatar" => "users/registrations#edit_avatar", :as => "edit_user_avatar"
    post "users/update_avatar" => "users/registrations#update_avatar", :as => "update_user_avatar"
    post "users" => "users/registrations#update", :as => "user_registration"
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
      member do
        post "upload/:asset_type", to: "sessions#upload", as: :upload_asset_to
        get "tab/:tab", to: "sessions#show", as: :tab, constraints: { tab: /(photos|consent_forms|data_points)/ }
      end

      resources :data_points, except: [:index] do
        member do
          post "bookmark"
          post "unbookmark"
        end
      end

      resources :consent_forms, except: [:new]
      resources :photos, only: [:index, :show, :destroy]
    end
  end

  resources :projects, only: [] do
    resources :members, only: [:index, :show]
  end
end
