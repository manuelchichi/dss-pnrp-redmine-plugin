Redmine::Plugin.register :dss_pnrp do
  name 'Dss Pnrp plugin'
  author 'Author name'
  description 'Decision Support System'
  version '0.0.3'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  menu :application_menu, :polls, { controller: 'polls', action: 'index' }, caption: 'Polls'
  permission :priorization_process, { priorization_process: [:index, :vote] }, public: true
  menu :project_menu, :priorization_process, { controller: 'priorization_process', action: 'index' }, caption: 'Priorization Process', param: :project_id
end
