Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  devise_for :users

  get "admin", to: "admin/people#index"

  get "/search_results", to: "pages#search"

  resources :documents
  resources :document_files
  resources :people
  resources :family_links
  resources :aliases do
    get "delete"
  end

  namespace :admin do
    get "documents_search", to: "documents#search"
    get "funds_search",     to: "funds#search"
    get "people_search",    to: "people#search"

    resources :people do
      resources :family_links
    end

    resources :documents do
      resources :document_files
      resources :document_people
    end

    resources :document_files do
      get "delete"
    end

    resources :document_people do
      get "delete"
    end

    resources :family_links do
      get "delete"
    end

    resources :funds
    resources :users do 
      get "make_admin"
      get "revoke_admin"
    end
  end

end
