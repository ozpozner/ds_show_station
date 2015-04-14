class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :stationID
      t.integer :logoID

      t.timestamps
    end
  end
end
