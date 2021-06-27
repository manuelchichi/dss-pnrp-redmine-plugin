class PpCriteriaIssue < ActiveRecord::Base
    belongs_to :issue
    belongs_to :pp_criteria
end
