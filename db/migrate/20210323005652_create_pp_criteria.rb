class CreatePpCriteria < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_criteria do |t|
      t.belongs_to :priorization_process
      t.string :name
      t.string :description
      t.integer :default_value
    end
  end
end
