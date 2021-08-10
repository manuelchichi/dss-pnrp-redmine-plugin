class PriorizationProcessController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  
  before_action :find_priorization_process, only: [:show, :execute, :execute_create ] 
  before_action :find_project, only: [:new, :create] 

  def posttest
   
    uri = URI.parse("http://flaskapp:80/post")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump({
      "key1" => "value1",
      "key2" => "value2"
    })
    
    req_options = {}
    
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end

  def retrive_query_prp
    
    ## result = Net::HTTP.get(URI.parse('http://www.example.com/about.html'))
    

    data_hash = {}

    File.open('/bitnami/redmine/plugins/dss_pnrp/app/controllers/prp_issues_result.json') do |f|
      data_hash = JSON.parse(f.read)
    end
    
    returned_alternatives = data_hash['alternatives']

    #Ordenar la board aca. Issues 

    priorities = IssuePriority.all

    @alternatives = []
    returned_alternatives.each do |alternative|

      board = []
      priorities.each do |priority|
        #Inicializar prioridades.
        board_element = Hash.new
        board_element[:id] = priority.id
        board_element[:name] = priority.name
        board_element[:issues] = []
        board << board_element 
      end

      alternative['issues'].each do |issue|
        
        new_issue = Issue.find(issue['issue_id']) #Esto deberia hashearse en una tabla, si existe no se busca.
        new_issue.priority_id = issue['priority_id']

        #Agregar al diccionario ordenado por prioridad. 
        board.each do |board_element|
          if (board_element[:id] == new_issue.priority_id)
            board_element[:issues] = board_element[:issues] << new_issue
          end
        end

      end
      @alternatives << [ alternative['alternative_id'], board ]
    end
    
  end

  def alternatives
    retrive_query_prp
  end

  def find_priorization_process
    @pp = PriorizationProcess.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def retrieve_algorithms_prp
    uri = URI.parse("http://flaskapp:80/get")
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
    @criterias = PpCriteria.where(priorization_process_id: @pp['id'])
  end

  def show
    retrieve_criteria_prp
    @PpDecisionMakers = PpDecisionMaker.where(priorization_process_id: @pp['id'])
    @ppRIssues = PpRelatedIssue.where(priorization_process_id: @pp['id'])
  end

  def execute
    posttest
    retrieve_algorithms_prp
    retrieve_criteria_prp
  end

  def execute_create

    arrayOfPonderations = []
    arrayOfParameters = []
    arrayOfIssuePonderations = []
    arrayOfCriteriaPonderations = []

    ppe = PpExecution.create(user: User.current, priorization_process: @pp, created_at: Time.now, updated_at: Time.now)
    
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
    
    postJson = {:execution_id => ppe.id,:issue_ponderation => arrayOfIssuePonderations , :algorithm => {id: ppa.id, parameters: arrayOfParameters}, :ponderations => arrayOfCriteriaPonderations }.to_json

    puts postJson

    redirect_to(priorization_process_path(@pp))
  end

  def new
    @persons = User.find(@project.members.map(&:user_id))
    @issues = Issue.find(@project.issue_ids)
  end

  def create
    # Si ya existe uno inicializado que de error.
    pp = PriorizationProcess.create(project_id: @project.id, status: 1, created_at: Time.now, updated_at: Time.now)
        
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

end
