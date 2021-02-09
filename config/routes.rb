Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "users#index"

  get '/create', to: 'users#create'

  get '/destroy', to: 'users#destroy'

  get '/match_create', to: 'matches#match_create'

  get '/match_destroy', to: 'matches#match_destroy'

  get '/add_player_to_squad', to: 'users#add_player_to_squad'

  get '/match_show', to: 'matches#show'

  get '/destroy_player', to: 'users#destroy_player'

  get '/add_goal_scored', to: 'matches#add_goal_scored'

  get '/subtract_goal_scored', to: 'matches#subtract_goal_scored'

  get '/team_show', to: 'teams#show'
  
end
