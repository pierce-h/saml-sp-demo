Rails.application.routes.draw do
  devise_for :users

  resources :saml, only: :index do
    collection do
      get :sso
      post :acs
      get :metadata
      get :logout
    end
  end

  root to: "pages#home"
end
