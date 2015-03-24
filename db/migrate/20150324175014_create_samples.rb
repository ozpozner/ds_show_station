class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.integer :routeId
      t.integer :prevHBS
      t.integer :currentHBS
      t.integer :nextHBS
      t.integer :hmu1
      t.integer :hmu2
      t.integer :hmu1_RSSI
      t.integer :hmu2_RSSI
      t.float :hmu1_DATA
      t.float :hmu2_DATA
      t.string :hmu1_HBS
      t.string :hmu2_HBS

      t.timestamps
    end
  end
end
