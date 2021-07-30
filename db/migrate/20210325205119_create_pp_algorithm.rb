class CreatePpAlgorithm < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_algorithms do |t|
      t.belongs_to :pp_execution
      t.string :name
      t.string :version
    end
  end
end
