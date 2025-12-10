module DssPnrp
  def self.setup
    Rails.configuration.to_prepare do
      require_dependency File.expand_path('dss_pnrp/patches/issue_patch', __dir__)
      require_dependency File.expand_path('dss_pnrp/patches/issues_controller_patch', __dir__)
      require_dependency File.expand_path('dss_pnrp/hooks/views_issues_hook', __dir__)
    end

    Issue.include(DssPnrp::Patches::IssuePatch)
    IssuesController.include(DssPnrp::Patches::IssuesControllerPatch)
  end
end

DssPnrp.setup
