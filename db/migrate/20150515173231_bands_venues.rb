class BandsVenues < ActiveRecord::Migration
  def change
    create_table :bands_venues do |t|
      t.column :band_id, :int
      t.column :venue_id, :int
    end

  end
end
