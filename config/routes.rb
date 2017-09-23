Rails.application.routes.draw do
  put '/credit_cards', to: 'credit_cards#update'
  delete '/credit_cards', to: 'credit_cards#destroy'
  get '/credit_card', to: 'credit_cards#show'
  resources :credit_cards, only: [:create,:update, :show, :index, :destroy] do
    collection do
     get '/user', to: 'credit_cards#user', as: 'byuser'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
