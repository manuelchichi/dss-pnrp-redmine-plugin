class PriorizationProcessController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  
  before_action :find_priorization_process, only: [:show, :executions, :execute, :execute_create, :retrive_query_prp, :solution_create, :solution_apply, :alternatives] 
  before_action :find_project, only: [:new, :create] 
  before_action :find_project_from_prp, only: [:show] 
  before_action :find_execution, only: [:execution] 

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_project_from_prp
    @project = PriorizationProcess.find(params[:id]).project
  end

  def find_priorization_process
    @pp = PriorizationProcess.find(params[:id])
  end

  def find_execution
    @ppExecution = PpExecution.find(params[:id_execution])
  end

  def retrive_query_prp
    urlString = "http://fastapi:80/execution/1" 
    uri = URI.parse(urlString)
    request = Net::HTTP::Get.new(uri)
    request.content_type = "application/json"
    request["Accept"] = "application/json"

    req_options = {}

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    solution = JSON.parse(response.body)["solution"]
    issues = Issue.find(solution.map { |x| x['issue_id'] })

    @sorted_solution = solution.sort_by{ |hash| hash['position'].to_i }
    @priorities = IssuePriority.all
    
    
    #Rails.logger.debug "Values"
    #Rails.logger.debug "#{response.body}"
  end

  def retrieve_algorithms_prp
    uri = URI.parse("http://fastapi:80/algorithms")
    request = Net::HTTP::Get.new(uri)
    request.content_type = "application/json"
    request["Accept"] = "application/json"

    req_options = {}

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    @algorithms = []
    data_hash = {}

    data_hash = JSON.parse(response.body)

    returned_algorithms = data_hash['algorithms'] #Por ahora lo dejo de esta forma por si hay que modificar algo.
    returned_algorithms.each do |algorithm| #Aqui lo mismo, por si hay que agregarle cosas.
        @algorithms << algorithm
    end 
  end
  
  def retrieve_criteria_prp
    @ppCriterias = PpCriteria.where(priorization_process_id: @pp['id'])
  end

  def show
    retrieve_criteria_prp
    @ppDecisionMakers = PpDecisionMaker.where(priorization_process_id: @pp['id'])
    @pprIssues = PpRelatedIssue.where(priorization_process_id: @pp['id'])
    @ppExecutions = PpExecution.where(priorization_process_id: @pp['id'])
  end

  def alternatives
    priorities = IssuePriority.all

    @alternatives = []

    pp_executions = PpExecution.where(priorization_process_id: @pp['id'])
    
    pp_executions.each do |execution|
      solutions = PpSolution.where(pp_execution_id: execution['id'])
      solutions.each do |solution|

        board = []

        priorities.each do |priority|
          #Inicializar prioridades.
          board_element = Hash.new
          board_element[:id] = priority.id
          board_element[:name] = priority.name
          board_element[:issues] = []
          board << board_element 
        end

        issue_solutions = PpSolutionIssue.where(pp_solution_id: solution['id'])
        issue_solutions.each do |issue_solution|
          board.each do |board_element|
            if (board_element[:id] == issue_solution.priority)
              board_element[:issues] = board_element[:issues] << issue_solution.issue
            end
          end
        end
        @alternatives << [ execution['id'], solution['is_applied'], solution['id'], board ]
      end
    end
  end

  def execution
    retrive_query_prp
  end

  def execute
    retrieve_algorithms_prp
    retrieve_criteria_prp
  end

  def execute_create

    arrayOfPonderations = []
    arrayOfParameters = []
    arrayOfIssuePonderations = []
    arrayOfCriteriaPonderations = []

    ppe = PpExecution.create(user: User.current, priorization_process: @pp, is_solution_created: false)
    
    alg = params[:algorithms][params[:selected]]

    ppa = PpAlgorithm.find_or_create_by(id: alg["id"]) do | newAlg |
       newAlg.pp_execution_id = ppe.id
       newAlg.name = alg["name"]
       newAlg.version = alg["version"]
    end

    alg["parameters"].each do | param |
      PpAlgorithmParameter.create(pp_algorithm_id: ppa.id, name: param[0], value: param[1]["value"])
      arrayOfParameters << { param[1]["id"] => param[1]["value"] }
    end
    
    params[:criterias].each do | criteria |
      PpCriteriaPonderation.create(pp_execution_id: ppe.id,pp_criteria_id: criteria[0],value: criteria[1])
      arrayOfCriteriaPonderations << { criteria[0] => criteria[1] }
      criteriaIssues = PpCriteriaIssue.where(pp_criteria_id: criteria[0])
      criteriaIssues.each do | criteriaIssue |
        arrayOfIssuePonderations << { criteria_id: criteriaIssue['pp_criteria_id'], issue_id: criteriaIssue['issue_id'], value: criteriaIssue['value'] }
      end
    end
    priorities = IssuePriority.all

    postJson = {:execution_id => ppe.id, :issue_ponderation => arrayOfIssuePonderations, :priorization_process_id => @pp.id, :priorities => priorities.pluck(:id,:name,:position,:active)  ,:algorithm => {id: ppa.id, parameters: arrayOfParameters}, :ponderations => arrayOfCriteriaPonderations }.to_json

    uri = URI.parse("http://fastapi:80/execution")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = postJson
    req_options = {}
    
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    redirect_to(priorization_process_path(@pp))
  end

  def solution_create
    solution = PpSolution.create(pp_execution_id: params[:execution_id], priorization_process_id: @pp['id'], is_applied: false)
    sol_issues = params[:sol_issues]
    sol_issues.each do |issue|   
      new_sol_issue = PpSolutionIssue.create(issue_id: issue[0], pp_solution_id: solution["id"] ,priority: issue[1]["priority"])
    end

    PpExecution.update(params[:execution_id], is_solution_created: true)

    redirect_to(priorization_process_path(@pp))
  end

  def solution_apply
    sol_issues = PpSolutionIssue.where(pp_solution_id: params[:selected_alternative])
    sol_issues.each do |sol_issue| 
      issue = sol_issue.issue
      issue.priority = IssuePriority.find(sol_issue.priority)
      issue.save
    end

    PpSolution.update(params[:selected_alternative], is_applied: true)
    PriorizationProcess.update(@pp['id'], is_ended: true)

    redirect_to(priorization_process_path(@pp))
  end

  def new
    @persons = User.find(@project.members.map(&:user_id))
    @issues = Issue.find(@project.issue_ids)
  end

  def create
    # Si ya existe uno inicializado que de error.
    pp = PriorizationProcess.create(project_id: @project.id, is_ended: false)
        
    arrayOfCriterias = []

    params[:criterias].each do | criteria |
      arrayOfCriterias << PpCriteria.create(priorization_process_id: pp.id, name: criteria[:name], description: criteria[:description], default_value: criteria[:value])
    end
    
    params[:issues_ids].each do | id |
      PpRelatedIssue.create(priorization_process_id: pp.id, issue_id: id, old_priority: 0, new_priority: 0, status:0)
      arrayOfCriterias.each do | criteria |
        PpCriteriaIssue.create(issue_id: id,pp_criteria_id: criteria.id,value: criteria.default_value)
      end
    end

    params[:persons_ids].each do | id |
      PpDecisionMaker.create(priorization_process_id: pp.id, user_id: id, admin: false)
    end
  
    redirect_to(index_requeriment_engineering_path())
  end
 
  def is_ended?
    self.is_ended
  end

end
