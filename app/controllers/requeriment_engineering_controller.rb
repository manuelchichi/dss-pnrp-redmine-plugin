class RequerimentEngineeringController < ApplicationController
  before_action :find_project, only: [:index] 

  def index
    @pps = PrioritizationProcess.where(project_id: @project['id'])  
    @nrp = Issue.all  #NrpProcess.where(project_id: @project['id'])  
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

end
