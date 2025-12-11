module DssPnrp
    class InitsLoader
        def self.run
            admin_user = User.find_by(login: 'admin') || User.admin.first || User.first
            raise "No admin user found for Inits migration" unless admin_user

            default_role = Role.find_by(name: 'Manager') || Role.givable.first || Role.first
            raise "No role found for Inits migration" unless default_role

            status   = IssueStatus.first
            priority = IssuePriority.first
            tracker  = Tracker.first
            
            #Project 1
            project1 = Project.create(identifier: "project-1",name: "Proyecto 1")
            Member.create_principal_memberships(admin_user, project_ids: [project1.id], role_ids: [default_role.id])
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
              issue = Issue.new(tracker: tracker, project: project1, subject: "Issue "+ (i+1).to_s, description: "test issue", status: status, priority: priority, author: admin_user)
            unless issue.save
                raise "Issue not created: #{issue.errors.full_messages.join(', ')}"
            end
            relation = PpRelatedIssue.create(prioritization_process_id: ppp1.id,issue_id: issue.id)
            for k in 0..2 do
                PpCriteriaIssue.create(issue_id: issue.id, pp_criteria_id: arrayOfCriteria[k].id , value: criteriasvaluep1[i][k])
            end

            end

            #Project 2
            project2 = Project.create(identifier: "project-2",name: "Proyecto 2")
            Member.create_principal_memberships(admin_user, project_ids: [project2.id], role_ids: [default_role.id])
            ppp2 = PrioritizationProcess.create(project_id: project2.id, is_ended: false)
            criteriasp2 = [{name: "Beneficio", description:"", default_value: 20},{name: "Complejidad", description:"", default_value: 30},{name: "Interaccion", description:"", default_value: 50}]
            criteriasvaluep2 = [[80,70,50],[100,80,20],[20,50,70],[10,40,50],[10,50,70],[5,30,5],[30,100,100],[20,15,60],[10,100,50],[35,45,80],
                                [80,35,20],[35,45,45],[90,90,50],[10,30,80],[50,20,50],[35,75,75],[75,55,30],[30,30,30],[65,35,45],[40,70,20],
                                [70,35,75],[100,20,30],[50,100,50],[75,80,100],[50,50,75],[20,45,60],[65,60,80],[80,50,45],[15,40,60],[5,15,40],
                                [40,50,20],[70,50,10],[40,50,80],[15,75,50],[50,95,100],[30,85,15],[60,55,10],[65,45,80],[50,25,55],[25,65,70],
                                [40,20,10],[85,20,35],[80,40,90],[95,15,35],[30,80,50],[55,10,40],[75,45,65],[35,65,40],[85,60,15],[95,100,100]]
            arrayOfCriteria = []
            
            #Criteria 2
            for i in 0..2 do
            arrayOfCriteria << PpCriteria.create(prioritization_process_id: ppp2.id, name: criteriasp2[i][:name], description: criteriasp2[i][:description], default_value: criteriasp2[i][:default_value].to_f )
            end
            
            #Issues 2
            for i in 0..49 do
            
              issue = Issue.new(tracker:  tracker, project: project2, subject: "Issue "+ (i+11).to_s, description: "test issue", status: status, priority: priority, author: admin_user)
            unless issue.save
                raise "Issue not created: #{issue.errors.full_messages.join(', ')}"
            end
            relation = PpRelatedIssue.create(prioritization_process_id: ppp2.id,issue_id: issue.id)
            for k in 0..2 do
                PpCriteriaIssue.create(issue_id: issue.id, pp_criteria_id: arrayOfCriteria[k].id , value: criteriasvaluep2[i][k])
            end

            end
        end 
    end
end
