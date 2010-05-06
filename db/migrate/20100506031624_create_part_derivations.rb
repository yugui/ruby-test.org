class CreatePartDerivations < ActiveRecord::Migration
  def self.up
    create_table :part_derivations do |t|
      t.references :from, null: false
      t.references :to, null: false
    end
  end

  def self.down
    drop_table :part_derivations
  end
end
