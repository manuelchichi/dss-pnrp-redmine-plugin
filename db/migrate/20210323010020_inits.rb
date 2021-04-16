class Inits < ActiveRecord::Migration[5.2]
  def up
    PriorizationProcess.create(project_id: 1, created_on: Time.now.to_i, updated_on: Time.now.to_i, status: 1)

    PpRelatedIssue.create(priorization_process_id: 1,issue_id: 1, old_priority: 1, new_priority: 3, status:1)

    #PpCriteria.create(priorization_process_id: 1, name: "Criteria Test",description: "This is a criteria",field_id: 1, default_value: 5)
  
    #PpDecisionMaker.create(priorization_process_id: 1, user_id: 1, admin: false)

    #PpCriteriaPonderation.create(pp_criteria_id: 1, user_id: 1, value: 50)
  
  end

  def down
    PriorizationProcess.delete_all
    PPRelatedIssue.delete_all
    PPCriteria.delete_all
    PpDecisionMaker.delete_all
    PpCriteriaPonderation.delete_all
  end
end
