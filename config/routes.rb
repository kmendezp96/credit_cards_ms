Rails.application.routes.draw do
  resources :credit_cards do
   collection do
     get '/user', to: 'credit_cards#user', as: 'byuser'
   end
 end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
