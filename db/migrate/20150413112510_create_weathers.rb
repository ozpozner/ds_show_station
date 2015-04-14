class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.string :woeid
      t.string :tempHigh
      t.string :tempLow
      t.string :name
      t.datetime :fordate
      t.integer :iconID
      t.string :title
      t.integer :temp
      t.text :condText

      t.timestamps
    end
  end
end
