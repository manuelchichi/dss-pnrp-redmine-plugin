class CreatePpSolutionIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_solution_issues do |t|
      t.belongs_to :issue
      t.belongs_to :pp_solution
      t.integer :old_priority
      t.integer :new_priority
    end
  end
end
