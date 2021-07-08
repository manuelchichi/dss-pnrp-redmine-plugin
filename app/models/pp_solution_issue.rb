class PpSolutionIssue < ActiveRecord::Base
    belongs_to :issue
    belongs_to :pp_solution
end
