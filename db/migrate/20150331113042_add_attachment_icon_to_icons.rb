class AddAttachmentIconToIcons < ActiveRecord::Migration
  def self.up
    change_table :icons do |t|
      t.attachment :icon
    end
  end

  def self.down
    remove_attachment :icons, :icon
  end
end
