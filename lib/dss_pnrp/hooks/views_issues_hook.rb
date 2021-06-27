module DssPnrp
    module Hooks
      class ViewsIssuesHook < Redmine::Hook::ViewListener
        render_on :view_issues_show_details_bottom, :partial => "issues/criteria_issue"
        render_on :view_issues_form_details_bottom, :partial => "issues/criteria_issue_form"
      end
    end
end