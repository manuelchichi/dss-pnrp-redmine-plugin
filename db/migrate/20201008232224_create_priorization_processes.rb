class CreatePriorizationProcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :priorization_processes do |t|
      t.integer :project_id
      t.timestamp :created_on
      t.timestamp :updated_on
      t.integer :status
    end
    
    create_table :pp_related_issues do |t|
      t.integer :priorization_process_id
      t.integer :issue_id
      t.integer :old_priority
      t.integer :new_priority
      t.integer :status
    end

    create_table :pp_criteria do |t|
      t.integer :priorization_process_id
      t.string :name
      t.string :description
      t.integer :field_id
    end

    create_table :pp_decision_makers do |t|
      t.integer :priorization_process_id
      t.integer :user_id
      t.boolean :admin
    end

    create_table :pp_criteria_ponderation do |t|
      t.integer :pp_criteria_id
      t.integer :user_id
      t.integer :value
    end


  end
end
