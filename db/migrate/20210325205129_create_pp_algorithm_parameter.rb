class CreatePpAlgorithmParameter < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_algorithm_parameters do |t|
      t.belongs_to :pp_algorithm
      t.string :name
      t.integer :value
    end
  end
end
