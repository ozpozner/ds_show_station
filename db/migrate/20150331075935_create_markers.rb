class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.integer :zoom
      t.integer :iconID
      t.string :href

      t.timestamps
    end
  end
end
