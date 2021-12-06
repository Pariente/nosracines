Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  devise_for :users

  get "admin",            to: "admin/people#index"
  get "/search_results",  to: "pages#search"
  get "private_content",  to: "pages#private_content"
  get "search_people",    to: "people#search"
  get "search_documents", to: "documents#search"
  get "search_events",    to: "events#search"
  get "search_locations", to: "locations#search"

  resources :documents
  resources :document_files
  resources :people
  resources :events
  resources :locations
  resources :family_links

  resources :aliases do
    get "delete"
  end

  namespace :admin do
    get "documents_search", to: "documents#search"
    get "funds_search",     to: "funds#search"
    get "people_search",    to: "people#search"
    get "events_search",    to: "events#search"
    get "locations_search", to: "locations#search"

    resources :people do
      resources :family_links
      resources :event_people
    end

    resources :documents do
      resources :document_files
      resources :document_people
      resources :event_documents
    end

    resources :events

    resources :locations do
      resources :location_documents
      resources :location_events
      resources :location_people
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

    resources :event_people do
      get "delete"
    end

    resources :event_documents do
      get "delete"
    end

    resources :location_documents do
      get "delete"
    end

    resources :location_events do
      get "delete"
    end

    resources :location_people do
      get "delete"
    end

    resources :funds

    resources :users do 
      get "make_admin"
      get "revoke_admin"
      get "give_private_access"
      get "revoke_private_access"
    end
  end

end
