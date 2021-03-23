class CreatePriorizationProcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :priorization_processes do |t|
      t.integer :project_id
      t.timestamp :created_on
      t.timestamp :updated_on
      t.integer :status
    end
  end
end
