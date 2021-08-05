class CreatePpAlgorithmParameter < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_algorithm_parameters do |t|
      t.belongs_to :pp_algorithm
      t.string :name
      t.float :value
    end
  end
end
