Rails.configuration.to_prepare do
    require 'dss_pnrp/patches/issue_patch'
    require 'dss_pnrp/patches/issue_controller_patch'
    require 'dss_pnrp/hooks/views_issues_hook'
end