class CreateBundleDerivations < ActiveRecord::Migration
  def self.up
    create_table :bundle_derivations do |t|
      t.references :from, null: false
      t.references :to, null: false
    end
  end

  def self.down
    drop_table :bundle_derivations
  end
end
