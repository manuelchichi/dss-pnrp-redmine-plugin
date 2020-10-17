class PriorizationProcessController < ApplicationController

  def index
    @project = Project.find(params[:project_id])

    @issues = Issue.all

  end
  
  def init
  end

  def run
  end

  def get
  end

  def change
  end
end
