require "sidekiq/web"

Rails.application.routes.draw do
  root to: "projects#index"

  get ".well-known/acme-challenge/5SVB40yrS6hlGwelHHILzwsC0x4YR0xwRWJvuaNKnTg", to: proc { [200, {}, ["5SVB40yrS6hlGwelHHILzwsC0x4YR0xwRWJvuaNKnTg.ctiOeEcwoY-q4JwybuZXPquWrI9vj1H97tLhG2SjD_A"]] }
  get ".well-known/acme-challenge/lbN_DvT6RC-2w_uvbNbw6khfWm4CNYH6MyySbuPc9Kw", to: proc { [200, {}, ["lbN_DvT6RC-2w_uvbNbw6khfWm4CNYH6MyySbuPc9Kw.ctiOeEcwoY-q4JwybuZXPquWrI9vj1H97tLhG2SjD_A"]] }

  # Sidekiq
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

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
      post "upload/:asset_type", on: :member, to: "sessions#upload", as: :upload_asset_to

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
