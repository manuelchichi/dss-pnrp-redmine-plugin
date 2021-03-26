class CreatePpCriteriaPonderations < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_criteria_ponderations do |t|
      t.integer :pp_criteria_id
      t.integer :user_id
      t.integer :value
    end
  end
end
