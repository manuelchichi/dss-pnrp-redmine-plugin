class CreatePpCriteriaPonderations < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_criteria_ponderations do |t|
      t.belongs_to :pp_criteria
      t.belongs_to :pp_execution
      t.float :value
    end
  end
end
