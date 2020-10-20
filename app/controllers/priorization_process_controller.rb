class PriorizationProcessController < ApplicationController
  before_action :find_project, :authorize, only: :index

  helper :queries
  include QueriesHelper
  
  def index
    use_session = !request.format.csv?
    retrieve_query(IssueQuery, use_session)

    if @query.valid?
        @issues = @query.issues()
        render :layout => !request.xhr?
    else
        render :layout => !request.xhr?
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def find_project
    @project = Project.find(params[:project_id])
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
