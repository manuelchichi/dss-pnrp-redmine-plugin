class CreatePpDecisionMakers < ActiveRecord::Migration[5.2]
  def change
    create_table :pp_decision_makers do |t|
      t.integer :priorization_process_id
      t.integer :user_id
      t.boolean :admin
    end
  end
end
