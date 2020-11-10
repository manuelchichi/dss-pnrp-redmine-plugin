class PriorizationProcessController < ApplicationController
  before_action :find_project, :authorize, only: :index

  helper :queries
  include QueriesHelper
  
  def index
    retrieve_query(IssueQuery, true)
    ## Hay que hacer un comando que sea: retrive_query_prp
    ## Este debe traer los issues, board_columns y issue_board

    if @query.valid?
        @issues = @query.issues()
        #@issue_board = @query.issue_board
        #@board_columns = @query.board_statuses

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
