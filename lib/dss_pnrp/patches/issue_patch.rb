require_dependency 'issue'

module DssPnrp
  module Patches
    module IssuePatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          has_many :pp_criteria_issues
        end
    
      end
    end
    
    module InstanceMethods
    end

  end
end

unless Issue.included_modules.include?(DssPnrp::Patches::IssuePatch)
    Issue.send(:include, DssPnrp::Patches::IssuePatch)
end