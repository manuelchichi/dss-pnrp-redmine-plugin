Redmine::Plugin.register :dss_pnrp do
  name 'Requirement engineering plugin'
  author 'GICIIS'
  description 'Decision Support System'
  version '0.0.3'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  permission :requeriment_engineering, { requeriment_engineering: [:index] }, public: true

  #Usar PROC para que solo se pueda ver si es el raiz. 
  # :if => Proc.new { Project.current.root? }
  menu :project_menu, :requeriment_engineering, { controller: 'requeriment_engineering', action: 'index' }, caption: 'Requeriment Engineering', param: :project_id
end
