class CreatePpCriteriasPonderations < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_criterias_ponderations do |t|
      t.belongs_to :pp_criteria
      t.belongs_to :user
      t.integer :value
    end
  end
end
