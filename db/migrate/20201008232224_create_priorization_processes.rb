class CreatePriorizationProcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :priorization_processes do |t|
      t.belongs_to :project
      t.boolean :is_ended
      t.timestamps
    end
  end
end
