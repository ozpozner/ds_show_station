class CreateSnmps < ActiveRecord::Migration
  def change
    create_table :snmps do |t|
      t.string :oid
      t.string :s1
      t.string :s2
      t.string :s3
      t.string :s4
      t.string :s5
      t.string :s6
      t.string :s7
      t.string :s8
      t.string :s9
      t.string :s10
      t.string :rssi1
      t.string :rss2
      t.string :lmrv1
      t.string :lmrv2
      t.boolean :hmu1s
      t.boolean :hmu2s
      t.integer :numoflinks
      t.integer :deviceID
      t.string :ipaddr

      t.timestamps
    end
  end
end
