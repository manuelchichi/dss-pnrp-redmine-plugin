class Inits < ActiveRecord::Migration[5.2]
  def up
    
    #Project 1
    project1 = Project.create(identifier: "project-1",name: "Proyecto 1")
    Member.create_principal_memberships(User.find_by_id(1), project_ids: [1], role_ids: [3])
    ppp1 = PrioritizationProcess.create(project_id: project1.id, is_ended: false)
    criteriasp1 = [{name: "Beneficio", description:"", default_value: 20},{name: "Complejidad", description:"", default_value: 30},{name: "Interaccion", description:"", default_value: 50}]
    criteriasvaluep1 = [[80,70,50],[100,80,20],[20,50,70],[10,40,50],[10,50,70],[5,30,5],[30,100,100],[90,20,90],[15,15,10],[40,15,5]]
    arrayOfCriteria = []

    #Criteria 1
    for i in 0..2 do
      arrayOfCriteria << PpCriteria.create(prioritization_process_id: ppp1.id, name: criteriasp1[i][:name], description: criteriasp1[i][:description], default_value: criteriasp1[i][:default_value].to_f )
    end

    #Issues 1
    for i in 0..9 do
      issue = Issue.create(tracker_id: 2, project_id: project1.id, subject: "Issue "+ i.to_s, description: "test issue", status_id: 1, priority_id: 1, author_id: 1)
      relation = PpRelatedIssue.create(prioritization_process_id: ppp1.id,issue_id: issue.id)
      for k in 0..2 do
        PpCriteriaIssue.create(issue_id: issue.id, pp_criteria_id: arrayOfCriteria[k].id , value: criteriasvaluep1[i][k])
      end

    end


    #Project 2
    #Project.create(identifier: "project-2",name: "Proyecto 2")

    #Issues 2
    #for i in 1..50 do
    #  issue = Issue.create(tracker_id: 2, project_id: 1, subject: "Issue "+ i, description: "", status_id: 1, priority_id: 1, author_id: 1, start_date: Date.today)
    #end
  end

  def down
    PrioritizationProcess.delete_all
    PPRelatedIssue.delete_all
    PPCriteria.delete_all
    PpDecisionMaker.delete_all
    PpCriteriaPonderation.delete_all
    PpCriteriaIssues.delete_all
  end
end
