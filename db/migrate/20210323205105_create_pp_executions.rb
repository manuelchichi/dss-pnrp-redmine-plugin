class CreatePpExecutions < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_executions do |t|
      t.belongs_to :user
      t.belongs_to :priorization_process
      t.timestamps
    end
  end
end
