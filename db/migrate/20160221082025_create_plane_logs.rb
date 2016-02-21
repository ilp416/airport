class CreatePlaneLogs < ActiveRecord::Migration
  def change
    create_table :plane_logs do |t|
      t.references :plane, index: true, foreign_key: true
      t.string :state

      t.timestamps null: false
    end
  end
end
