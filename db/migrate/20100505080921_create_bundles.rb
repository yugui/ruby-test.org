class CreateBundles < ActiveRecord::Migration
  def self.up
    create_table :bundles do |t|
      t.string :signature, null: false
      t.text :name, null: false
      t.references :revision, null: false
    end
  end

  def self.down
    drop_table :bundles
  end
end
