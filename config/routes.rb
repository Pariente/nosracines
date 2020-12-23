Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  get '/search_results', to: 'pages#search'

  resources :documents
  resources :document_files
  resources :people
end
