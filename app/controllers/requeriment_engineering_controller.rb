class RequerimentEngineeringController < ApplicationController
  before_action :find_project, only: [:index] 

  def index
    @name  = "Vista de procesos y proximas entregas"
    @pps = PriorizationProcess.where(project_id: @project['id'])  
    @issues2 = Issue.all  #ProximoLanzamiento
  end

  #En el controlador de donde listo los criterios 

  def find_project
    @project = Project.find(params[:project_id])
  end

  def show
  end
end
