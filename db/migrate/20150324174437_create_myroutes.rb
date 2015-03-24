class CreateMyroutes < ActiveRecord::Migration
  def change
    create_table :myroutes do |t|
      t.string :name
      t.integer :routeId
      t.integer :deviceId
      t.integer :nextDeviceId
      t.integer :prevDeviceId

      t.timestamps
    end
  end
end
