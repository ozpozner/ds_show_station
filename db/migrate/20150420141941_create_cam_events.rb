class CreateCamEvents < ActiveRecord::Migration
  def change
    create_table :cam_events do |t|
      t.string :source
      t.string :eventTime
      t.string :eventType
      t.boolean :acknowledged
      t.datetime :acknowledged_at

      t.timestamps
    end
  end
end
