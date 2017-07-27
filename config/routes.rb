Rails.application.routes.draw do
  devise_for :users

  resources :saml, only: :index

  get "saml/sso",      to: "saml#sso",      as: :saml_sso
  get "saml/acs",      to: "saml#acs",      as: :saml_acs
  get "saml/metadata", to: "saml#metadata", as: :saml_metadata
  get "saml/logout",   to: "saml#logout",   as: :saml_logout

  root to: "pages#home"
end
