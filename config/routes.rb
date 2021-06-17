# Plugin's routes
# Guia de ruteo: http://guides.rubyonrails.org/routing.html

# Ruteos de prueba
get '/priorization_process_persons', to: 'priorization_process#persons'
get '/priorization_process_algorithms', to: 'priorization_process#algorithms'
get '/priorization_process_alternatives', to: 'priorization_process#alternatives'
get '/priorization_process_criteria', to: 'priorization_process#criteria'

# Ruteos produccion
get '/projects/:project_id/requeriment_engineering/index', to: 'requeriment_engineering#index'

resources :projects do
    resources :priorization_process, only: [:new, :create ]
  end
resources :priorization_process, only: [:show, :edit, :update, :destroy]

get '/priorization_process/:id/execute', to: 'priorization_process#execute' , as: :execute_priorization_process

resources :next_release_process