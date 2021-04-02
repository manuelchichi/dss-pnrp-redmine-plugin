class RequerimentEngineeringController < ApplicationController
  before_action :find_project

  def index
    @name  = "Vista de procesos y proximas entregas"
    @issues1 = Issue.all  #Priorizacion
    @issues2 = Issue.all  #ProximoLanzamiento
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def show
  end
end
