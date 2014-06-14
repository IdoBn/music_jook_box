class AddLatitudeAndLongitudeToParty < ActiveRecord::Migration
  def change
    add_column :parties, :latitude, :float
    add_column :parties, :longitude, :float
  end
end
