class CreatePriorizationProcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :priorization_processes do |t|
      t.belongs_to :project
      t.timestamp :created_on
      t.timestamp :updated_on
      t.integer :status
    end
  end
end
