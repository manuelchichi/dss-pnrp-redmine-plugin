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
