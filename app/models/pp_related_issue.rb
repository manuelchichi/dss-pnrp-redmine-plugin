class PpRelatedIssue < ActiveRecord::Base

    belongs_to :priorization_process
    belongs_to :issue
end
