# Plugin's routes
# Guia de ruteo: http://guides.rubyonrails.org/routing.html

get '/projects/:project_id/requeriment_engineering/index', to: 'requeriment_engineering#index', as: :index_requeriment_engineering

resources :projects do
    resources :prioritization_process, only: [:new, :create]
  end
resources :prioritization_process, only: [:show, :edit, :update, :destroy]

get '/prioritization_process/:id/execute', to: 'prioritization_process#execute' , as: :execute_prioritization_process
post '/prioritization_process/:id/execute', to: 'prioritization_process#execute_create' , as: :execute_create_prioritization_process
get '/prioritization_process/:id/executions/:id_execution', to: 'prioritization_process#execution' , as: :execution_prioritization_process
get '/prioritization_process/:id/alternatives', to: 'prioritization_process#alternatives' , as: :alternatives_prioritization_process
post '/prioritization_process/:id/alternatives', to: 'prioritization_process#solution_apply' , as: :solution_apply_prioritization_process
post '/prioritization_process/:id/solution', to: 'prioritization_process#solution_create' , as: :solution_create_prioritization_process

resources :next_release_process