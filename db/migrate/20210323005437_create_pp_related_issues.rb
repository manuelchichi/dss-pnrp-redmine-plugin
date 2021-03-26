class CreatePpRelatedIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_related_issues do |t|
      t.integer :priorization_process_id
      t.integer :issue_id
      t.integer :old_priority
      t.integer :new_priority
      t.integer :status
    end
  end
end
