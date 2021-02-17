Redmine::Plugin.register :dss_pnrp do
  name 'Dss Pnrp plugin'
  author 'GICIIS'
  description 'Decision Support System'
  version '0.0.3'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  permission :priorization_process, { priorization_process: [:index, :vote, :get] }, public: true

  #Usar PROC para que solo se pueda ver si es el raiz. 
  # :if => Proc.new { Project.current.root? }
  menu :project_menu, :priorization_process, { controller: 'priorization_process', action: 'index' }, caption: 'Priorization Process', param: :project_id
end
