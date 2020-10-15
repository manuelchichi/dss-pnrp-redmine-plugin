# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'polls', to: 'polls#index'
get 'priorization_process', to: 'priorization_process#index'
post 'post/:id/vote', to: 'polls#vote'
