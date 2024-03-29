require 'redmine'

Redmine::Plugin.register :dss_pnrp do
  name 'Decision Support System'
  author 'GICIIS'
  description 'Requirement engineering plugin'
  version '0.0.5'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  permission :requeriment_engineering, { requeriment_engineering: [:index] }, public: true
  permission :prioritization_process, { prioritization_process: [:index,:show] }, public: true

  project_module :prioritization_process do
    permission :see_prioritization_process, prioritization_process: :show
  end


  #Usar PROC para que solo se pueda ver si es el raiz. 
  # :if => Proc.new { Project.current.root? }
  menu :project_menu, :requeriment_engineering, { controller: 'requeriment_engineering', action: 'index' }, caption: 'Requeriment Engineering', param: :project_id
  settings default: {'backend_address' => "http://fastapi:80"}, partial: 'settings/pnrp_settings'

end

require 'dss_pnrp'