Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#home"

  get '/user', to: 'users#new'

  get '/create', to: 'users#create'

  get '/add_goal', to: 'users#add_goal'

  get '/subtract_goal', to: 'users#subtract_goal'

end
