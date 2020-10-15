Redmine::Plugin.register :dss_pnrp do
  name 'Dss Pnrp plugin'
  author 'Author name'
  description 'Decision Support System'
  version '0.0.2'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  menu :application_menu, :polls, { controller: 'polls', action: 'index' }, caption: 'Polls'
  menu :application_menu, :priorization_process, { controller: 'priorization_process', action: 'index' }, caption: 'Priorization Process'
end
