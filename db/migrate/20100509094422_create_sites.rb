class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.references :platform, null: false
      t.references :owner, null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :sites
  end
end
