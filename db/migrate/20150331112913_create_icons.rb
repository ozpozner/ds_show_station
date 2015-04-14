class CreateIcons < ActiveRecord::Migration
  def change
    create_table :icons do |t|
      t.integer :width
      t.integer :height
      t.string :altText
      t.string :url

      t.timestamps
    end
  end
end
