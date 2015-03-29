class CreateOids < ActiveRecord::Migration
  def change
    create_table :oids do |t|
      t.string :oid
      t.integer :deviceID
      t.integer :numRV
      t.string :returnType

      t.timestamps
    end
  end
end
