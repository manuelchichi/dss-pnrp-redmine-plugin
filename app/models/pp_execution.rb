class PpExecution < ActiveRecord::Base
    belongs_to :user
    belongs_to :prioritization_process
end
