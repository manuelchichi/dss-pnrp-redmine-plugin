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

    @alternatives = Array.new
    returned_alternatives.each do |alternative|

      @issues = Array.new
      alternative['issues'].each do |issue|
        new_member = Issue.find(issue['issue_id']) #Esto deberia hashearse en una tabla
        new_member.priority_id = issue['priority_id']
        @issues << new_member
      end
      
      @alternatives << [ alternative['alternative_id'], @issues ]
    end

  end

  def index
    retrive_query_prp
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
