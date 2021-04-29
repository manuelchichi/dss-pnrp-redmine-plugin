# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


get '/projects/:project_id/requeriment_engineering/index', to: 'requeriment_engineering#index'

get '/priorization_process_persons', to: 'priorization_process#persons'
get '/priorization_process_algorithms', to: 'priorization_process#algorithms'
get '/priorization_process_alternatives', to: 'priorization_process#alternatives'

#Esta hecho asi para usarlo desde el menu principal.
get '/priorization_process_show', to: 'priorization_process#show'

get '/priorization_process', to: 'priorization_process#index'
get '/priorization_process/:id', to: 'priorization_process#show'
post '/priorization_process', to: 'priorization_process#add'
put '/priorization_process/:id', to: 'priorization_process#modify'
delete '/priorization_process/:id', to: 'priorization_process#remove'

get '/next_release_process', to: 'next_release_process#index'
get '/next_release_process/:id', to: 'next_release_process#show'
post '/next_release_process', to: 'next_release_process#add'
put '/next_release_process/:id', to: 'next_release_process#modify'
delete '/next_release_process/:id', to: 'next_release_process#remove'