class CreatePlatforms < ActiveRecord::Migration
  def self.up
    create_table :platforms do |t|
      t.string :arch, null: false
      t.string :os, null: false
      t.string :misc, null: true

      t.index %w[ arch os misc ], unique: true
    end
  end

  def self.down
    drop_table :platforms
  end
end
