Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "users#index"

  post '/create', to: 'users#create'

  delete '/destroy', to: 'users#destroy'

  post '/match_create', to: 'matches#create'

  get '/match_show', to: 'matches#show'

  delete '/match_destroy', to: 'matches#destroy'

  post '/player_create', to: 'players#create'

  delete '/destroy_player', to: 'players#destroy'

  put '/add_goal_scored', to: 'players#add_goal_scored'

  put '/subtract_goal_scored', to: 'players#subtract_goal_scored'

  get '/team_show', to: 'teams#show'
end
