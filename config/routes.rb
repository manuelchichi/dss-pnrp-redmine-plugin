# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html


get '/priorization_process_get', to: 'priorization_process#get'
get '/priorization_process_algorithms', to: 'priorization_process#algorithms'
get '/priorization_process_view', to: 'priorization_process#view'

get '/priorization_process', to: 'priorization_process#index'
get '/priorization_process/:id', to: 'priorization_process#show'
post '/priorization_process', to: 'priorization_process#add'
put '/priorization_process/:id', to: 'priorization_process#modify'
delete '/priorization_process/:id', to: 'priorization_process#remove'

get '/nrp_process', to: 'nrp_process#index'
get '/nrp_process/:id', to: 'nrp_process#show'
post '/nrp_process', to: 'nrp_process#add'
put '/nrp_process/:id', to: 'nrp_process#modify'
delete '/nrp_process/:id', to: 'nrp_process#remove'