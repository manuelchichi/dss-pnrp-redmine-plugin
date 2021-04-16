class CreatePpRelatedIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_related_issues do |t|
      t.belongs_to :priorization_process
      t.belongs_to :issue
      t.integer :old_priority
      t.integer :new_priority
      t.integer :status
    end
  end
end
