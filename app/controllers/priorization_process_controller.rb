class PriorizationProcessController < ApplicationController
  require 'net/http'
  require 'json'
  
  before_action :find_project, :authorize, only: :index

  helper :queries
  include QueriesHelper
  

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

  def index
    retrive_query_prp
  end

  def find_project
    @project = Project.find(params[:project_id])
  end
  
  def init
  end

  def run
  end

  def get
    decisiontaker
    @people = User.all  #Invocar el objeto que tiene todas las personas
  end

  def change
  end

  def algorithms
    @name = "Algoritmos"
  end
end
