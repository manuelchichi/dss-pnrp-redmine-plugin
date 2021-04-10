class CreatePpDecisionMakers < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_decision_makers do |t|
      t.belongs_to :priorization_process
      t.belongs_to :user
      t.boolean :admin
    end
  end
end
