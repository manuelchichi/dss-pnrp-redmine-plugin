# Plugin's routes
# Guia de ruteo: http://guides.rubyonrails.org/routing.html

# Ruteos de prueba
get '/priorization_process_persons', to: 'priorization_process#persons'
get '/priorization_process_alternatives', to: 'priorization_process#alternatives'

# Ruteos produccion
get '/projects/:project_id/requeriment_engineering/index', to: 'requeriment_engineering#index', as: :index_requeriment_engineering

resources :projects do
    resources :priorization_process, only: [:new, :create]
  end
resources :priorization_process, only: [:show, :edit, :update, :destroy]

get '/priorization_process/:id/execute', to: 'priorization_process#execute' , as: :execute_priorization_process
post '/priorization_process/:id/execute', to: 'priorization_process#execute_create' , as: :execute_create_priorization_process
get '/priorization_process/:id/alternatives', to: 'priorization_process#alternatives' , as: :alternatives_priorization_process

post '/priorization_process/:id/solution', to: 'priorization_process#solution_create' , as: :solution_create_priorization_process
resources :next_release_process