class CreatePpSolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_solutions do |t|
      t.belongs_to :pp_execution
      t.belongs_to :prioritization_process
      t.boolean :is_applied
    end
  end
end
