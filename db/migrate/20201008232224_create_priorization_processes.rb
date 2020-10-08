class CreatePriorizationProcesses < ActiveRecord::Migration[5.2]
  def change
    create_table :priorization_processes do |t|
      t.string :alternatives
      t.boolean :finished
    end
  end
end
