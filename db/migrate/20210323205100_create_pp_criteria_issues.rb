class CreatePpCriteriaIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_criteria_issues do |t|
      t.belongs_to :pp_criteria
      t.belongs_to :issue
      t.integer :value
    end
  end
end
