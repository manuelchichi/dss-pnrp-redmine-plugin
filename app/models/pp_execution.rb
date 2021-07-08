class PpExecution < ActiveRecord::Base
    belongs_to :user
    belongs_to :priorization_process
end
