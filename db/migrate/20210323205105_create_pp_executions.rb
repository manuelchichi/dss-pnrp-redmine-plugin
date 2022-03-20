class CreatePpExecutions < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_executions do |t|
      t.belongs_to :user
      t.belongs_to :prioritization_process
      t.boolean :is_solution_created
      t.timestamps
    end
  end
end
