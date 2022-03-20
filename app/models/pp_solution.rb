class PpSolution < ActiveRecord::Base
    belongs_to :pp_execution
    belongs_to :prioritization_process
end
