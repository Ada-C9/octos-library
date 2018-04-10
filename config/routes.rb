Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#index'

  # get '/books/new_with_cover_photo'
  resources :books do

    # non-RESTful routes can be specified in a block
    # post '/check_out', to: 'books#check_out', as: 'check_out_book'
  end

  # or you can type them out manually
  # post '/books/:id/check_out', to: 'books#check_out', as: 'check_out_book'


  resources :authors do
    resources :books, only: [:index, :new]
  end

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  # Or, you can restrict what you want with :only or :except
  # resources :books, only: [:index, :new, :create]
  # resources :authors, except: [:destroy]
end
