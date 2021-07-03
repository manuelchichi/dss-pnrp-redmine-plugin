class PpCriteriaPonderation < ActiveRecord::Base
    belongs_to :user
    belongs_to :pp_criteria
    belongs_to :pp_execution
end
