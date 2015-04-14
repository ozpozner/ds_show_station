class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.float :lan
      t.float :lon
      t.integer :numOfConnections
      t.integer :iconID

      t.timestamps
    end
  end
end
