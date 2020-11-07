Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "users#index"

  get '/create', to: 'users#create'

  get '/add_goal', to: 'users#add_goal'

  get '/subtract_goal', to: 'users#subtract_goal'

  get '/add_match', to: 'users#add_match'

  get '/subtract_match', to: 'users#subtract_match'

  get '/destroy', to: 'users#destroy'

  get '/match_create', to: 'users#match_create'

  get '/match_destroy', to: 'users#match_destroy'

  get '/add_player_to_match', to: 'users#add_player_to_match'

end
