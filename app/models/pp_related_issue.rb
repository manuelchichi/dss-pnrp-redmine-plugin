class PpRelatedIssue < ActiveRecord::Base
    belongs_to :prioritization_process
    belongs_to :issue
end
