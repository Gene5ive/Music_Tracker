class Venues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.column :name, :string
    end

  end
end
