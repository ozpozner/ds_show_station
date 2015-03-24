class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :ip_addr
      t.string :login
      t.string :pass
      t.integer :nextID
      t.integer :prevID
      t.integer :type

      t.timestamps
    end
  end
end
