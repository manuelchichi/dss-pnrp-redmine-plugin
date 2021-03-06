class Inits < ActiveRecord::Migration[5.2]
  def up
    
    #Project
    Project.create(identifier: "project-1",name: "Proyecto 1")

    #Issues
    Issue.create(tracker_id: 2, project_id: 1, subject: "Issue 1", description: "El primer issue. Habia que empezar por algun lado.", status_id: 1, priority_id: 3, author_id: 1, start_date: Date.today)
    Issue.create(tracker_id: 2, project_id: 1, subject: "Issue 2", description: "El segundo issue. Otra feature a agregar", status_id: 1, priority_id: 3, author_id: 1, start_date: Date.today)
    Issue.create(tracker_id: 1, project_id: 1, subject: "Issue 3", description: "El tercer issue. Aparentemente hubo un problema.", status_id: 1, priority_id: 2, author_id: 1, start_date: Date.today)
    Issue.create(tracker_id: 1, project_id: 1, subject: "Issue 4", description: "El cuarto issue. Se rompio todo", status_id: 1, priority_id: 4, author_id: 1, start_date: Date.today)
    Issue.create(tracker_id: 2, project_id: 1, subject: "Issue 5", description: "El quinto issue. Nada serio.", status_id: 1, priority_id: 2, author_id: 1, start_date: Date.today)
    Issue.create(tracker_id: 2, project_id: 1, subject: "Issue 6", description: "El sexto issue. Puede esperar de ser necesario", status_id: 1, priority_id: 1, author_id: 1, start_date: Date.today)
    
    #PP1
    PriorizationProcess.create(project_id: 1, status: 1)
    #PP2
    PriorizationProcess.create(project_id: 1, status: 1)

    #Issue del PP1
    PpRelatedIssue.create(priorization_process_id: 1,issue_id: 1, old_priority: 3, new_priority: 2, status:1)
    PpRelatedIssue.create(priorization_process_id: 1,issue_id: 2, old_priority: 3, new_priority: 2, status:1)
    #Issue del PP2
    PpRelatedIssue.create(priorization_process_id: 2,issue_id: 3, old_priority: 2, new_priority: 4, status:1)
    PpRelatedIssue.create(priorization_process_id: 2,issue_id: 4, old_priority: 3, new_priority: 2, status:1)
    
    #Criterios
    PpCriteria.create(priorization_process_id: 1, name: "Time",description: "This is a criteria", default_value: 5)
    PpCriteria.create(priorization_process_id: 1, name: "Benefit",description: "This is a criteria", default_value: 50)
    
    #Tomadores de decisiones
    PpDecisionMaker.create(priorization_process_id: 1, user_id: 1, admin: false)

    #PpCriteriaPonderation.create(pp_criteria_id: 1, user_id: 1, value: 50)
  
  end

  def down
    PriorizationProcess.delete_all
    PPRelatedIssue.delete_all
    PPCriteria.delete_all
    PpDecisionMaker.delete_all
    PpCriteriaPonderation.delete_all
    PpCriteriaIssues.delete_all
  end
end
