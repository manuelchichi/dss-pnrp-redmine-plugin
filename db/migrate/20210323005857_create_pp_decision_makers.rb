class CreatePpDecisionMakers < ActiveRecord::Migration[6.1]
  def change
    create_table :pp_decision_makers do |t|
      t.belongs_to :prioritization_process
      t.belongs_to :user
      t.boolean :admin
    end
  end
end
