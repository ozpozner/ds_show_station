class Removehmudatafromsamples < ActiveRecord::Migration
  def change
    remove_column :samples, :hmu1_DATA
    remove_column :samples, :hmu2_DATA
    add_column :samples, :hbs1_RX, :integer
    add_column :samples, :hbs2_RX, :integer
    add_column :samples, :hmu1_TX, :integer
    add_column :samples, :hmu2_TX, :integer
  end
end


