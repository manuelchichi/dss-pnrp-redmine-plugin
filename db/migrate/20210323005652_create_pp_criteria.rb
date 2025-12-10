class CreatePpCriteria < ActiveRecord::Migration[6.1]
  def change
    create_table :pp_criteria do |t|
      t.belongs_to :prioritization_process
      t.string :name
      t.string :description
      t.float :default_value
    end
  end
end
