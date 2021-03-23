class CreatePpCriteria < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_criteria do |t|
      t.integer :priorization_process_id
      t.string :name
      t.string :description
      t.integer :field_id
      t.integer :default_value
    end
  end
end
