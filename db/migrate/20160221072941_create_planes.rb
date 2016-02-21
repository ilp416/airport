class CreatePlanes < ActiveRecord::Migration
  def change
    create_table :planes do |t|
      t.string :state

      t.timestamps null: false
    end
  end
end
