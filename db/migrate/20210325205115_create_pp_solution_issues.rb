class CreatePpSolutionIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_solution_issues do |t|
      t.belongs_to :issue
      t.belongs_to :pp_solution
<<<<<<< HEAD
      t.integer : priority
=======
      t.integer :priority
>>>>>>> 2d8b796dcab9d38090eb3a7d11e5a841cc2dac51
    end
  end
end
