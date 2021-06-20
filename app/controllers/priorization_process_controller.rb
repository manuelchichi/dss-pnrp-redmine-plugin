class PriorizationProcessController < ApplicationController
  require 'net/http'
  require 'json'
  
  before_action :find_priorization_process, only: [:show] 
  before_action :find_project, only: [:new] 
  

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

  def decisiontaker
    @name = "Proceso de priorización"
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

  def persons
    decisiontaker
    @people = User.all  #Invocar el objeto que tiene todas las personas

    if params[:search].blank?  
    else  
      @parameter = params[:search].downcase  
      @results = User.all.where("lower(firstname) LIKE :search", search: "%#{@parameter}%")  
    end 
  end

  def retrieve_algorithms_prp
    ## result = Net::HTTP.get(URI.parse('http://www.example.com/about.html'))
        
    @algorithms = []
    data_hash = {}

    File.open('/bitnami/redmine/plugins/dss_pnrp/app/controllers/algorithms_result.json') do |f|
      data_hash = JSON.parse(f.read)
    end

    returned_algorithms = data_hash['algorithms'] #Por ahora lo dejo de esta forma por si hay que modificar algo.
    returned_algorithms.each do |algorithm| #Aqui lo mismo, por si hay que agregarle cosas.
        @algorithms << algorithm
    end 
  end
  
  def retrieve_criteria_prp
      @criterias = []
      data_hash = {}

      File.open('/bitnami/redmine/plugins/dss_pnrp/app/controllers/criteria_result.json') do |f|
        data_hash = JSON.parse(f.read)
      end

      returned_criteria = data_hash['criteria']
      returned_criteria.each do |criteria| 
        @criterias << criteria 
      end
  end

  def show
    @name = "Show"
    @ppRIssues = PpRelatedIssue.where(priorization_process_id: @pp['id'])
  end

  def execute
    retrieve_algorithms_prp
    retrieve_criteria_prp
  end

  def new
    @people = User.find(@project.members.map(&:user_id))
  end

  def create
    # Si ya existe uno inicializado que de error.
    pp = PriorizationProcess.create(project_id: params[:project_id], created_on: Time.now.to_i, updated_on: Time.now.to_i, status: 1)
    # Crear campos en los issues en vez de tener que relacionar.
    # Crear Issues relacionados.
    # Crear miembro por cada persona.
    params[:persons_ids].each do | id |
      PpDecisionMaker.create(priorization_process_id: pp.id, user_id: id, admin: false)
    end
    redirect_to(index_requeriment_engineering_path())
  end

end
