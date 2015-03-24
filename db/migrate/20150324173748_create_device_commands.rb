class CreateDeviceCommands < ActiveRecord::Migration
  def change
    create_table :device_commands do |t|
      t.integer :deviceType
      t.string :command
      t.integer :numOfR
      t.integer :commandId

      t.timestamps
    end
  end
end
