module RedmineChecklists
    module Patches
      module IssuesControllerPatch
        def self.included(base) # :nodoc:
            base.send(:include, InstanceMethods)
            base.class_eval do
              unloadable # Send unloadable so it will not be unloaded in development
              before_action :save_before_state, :only => [:update]
            end
          end
      end

      module InstanceMethods
        def save_before_state
          params[:pp_criteria_issue].each do | criteria |
            updatedCriteria = PpCriteriaIssue.find(criteria[0])
            updatedCriteria.update(value: criteria[1]['value'])
          end
        end

      end
    end
end

unless IssuesController.included_modules.include?(RedmineChecklists::Patches::IssuesControllerPatch)
    IssuesController.send(:include, RedmineChecklists::Patches::IssuesControllerPatch)
end