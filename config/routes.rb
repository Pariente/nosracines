Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  get '/search_results', to: 'pages#search'

  resources :documents
  resources :document_files
  resources :people
  resources :family_links
  resources :aliases do
    get "delete"
  end

  namespace :admin do
    resources :people do
      resources :family_links
    end

    resources :documents do
      resources :document_files
    end

    resources :document_files do
      get "delete"
    end

    resources :family_links do
      get "delete"
    end
  end

end
