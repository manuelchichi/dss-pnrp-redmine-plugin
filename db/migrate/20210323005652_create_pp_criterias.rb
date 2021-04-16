class CreatePpCriterias < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_criterias do |t|
      t.belongs_to :priorization_process_id
      t.string :name
      t.string :description
      t.integer :field_id
      t.integer :default_value
    end
  end
end
